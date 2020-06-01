//
//  MainView.swift
//  StackOv
//
//  Created by Erik Basargin on 03/05/2020.
//  Copyright © 2020 Ephedra Software. All rights reserved.
//

import SwiftUI
import Combine

struct MainView: View {
    @EnvironmentObject var stackoverflowStore: StackoverflowStore
    @EnvironmentObject var transitionStore: TransitionStore
    
    @State private var selectedQuestion: QuestionId?
    
    init() {
        UITableViewCell.appearance().selectionStyle = .none
        UITableView.appearance().allowsSelection = false
        UITableView.appearance().separatorColor = .clear
        UITableView.appearance().separatorInset = UIEdgeInsets.zero
        UITableView.appearance().backgroundColor = UIColor.background
        UITableView.appearance().keyboardDismissMode = .onDrag
    }
    
    var body: some View {
        NavigationView {
            ZStack(alignment: .top) {
                Color.background
                    .edgesIgnoringSafeArea(.all)
                    .onTapGesture { UIApplication.shared.endEditing() }
                
                GeometryReader { _ in
                    ZStack(alignment: .center) { // this is cheat to change the base aligment
                        self.content
                    }
                }
                .padding(.top, NavigationBarView.Constants.height)
                
                NavigationBarView(.searchBar)
                    .edgesIgnoringSafeArea([.leading, .trailing])
                    .environmentObject(stackoverflowStore)
                    .environmentObject(transitionStore)
                    .disabled(stackoverflowStore.state.isUnknown)
            }
            .navigationBarTitle("")
            .navigationBarHidden(true)
            
            if !UIDevice.current.userInterfaceIdiom.isPhone {
                questionDetails
            }
        }
        .modifier(NavigationViewModifier())
        .onAppear {
            self.stackoverflowStore.loadQuestions()
        }
    }
    
    var content: some View {
        Group { () -> AnyView in
            switch stackoverflowStore.state {
            case .unknown:
                return AnyView(EmptyView())
            case .emptyContent:
                return AnyView(emptyContent)
            case .content:
                return AnyView(contentList)
            case .loading:
                return AnyView(loading)
            case .error:
                return AnyView(error)
            }
        }
    }
    
    var contentList: some View {
        GeometryReader { geometry in
            VStack(spacing: 16) {
                if UIDevice.current.userInterfaceIdiom.isPhone {
                    self.phoneList(geometry: geometry)
                } else {
                    self.tabletList(geometry: geometry)
                }
                
                if self.stackoverflowStore.nextLoading {
                    HStack(spacing: .zero) {
                        Spacer()
                        LoadingIndicatorView(.loadMoreForeground)
                            .frame(width: 20, height: 20)
                        Spacer()
                    }
                    .listRowInsets(EdgeInsets.zero)
                    .listRowBackground(Color.background)
                    .padding(.bottom)
                }
            }
        }
    }
    
    func phoneList(geometry: GeometryProxy) -> some View {
        List {
            ForEach(self.stackoverflowStore.state.content) { item in
                self.navigationLink(forItem: item, geometry: geometry)
            }
            .listRowBackground(Color.background)
        }
        .modifier(ListEdgesModifier(orientation: self.transitionStore.deviceOrientation))
    }

    func tabletList(geometry: GeometryProxy) -> some View {
        List {
            ForEach(self.stackoverflowStore.state.content) { item in
                self.navigationLink(forItem: item, geometry: geometry)
            }
            .listRowBackground(Color.background)
        }
    }
    
    var emptyContent: some View {
        UIApplication.shared.endEditing()
        return EmptyContentView()
    }
    
    var loading: some View {
        UIApplication.shared.endEditing()
        return LoadingIndicatorView()
            .frame(width: 30, height: 30)
    }
    
    var error: some View {
        UIApplication.shared.endEditing()
        return Text(stackoverflowStore.state.error?.localizedDescription ?? "")
    }
    
    var questionDetails: some View {
        QuestionDetailsView()
            .environmentObject(stackoverflowStore.questionStore)
    }
    
    func navigationLink(forItem item: QuestionItemModel, geometry: GeometryProxy) -> some View {
        ZStack {
            NavigationLink(
                destination: LazyView(self.questionDetails),
                tag: item.id,
                selection: Binding<QuestionId?>(
                    get: { self.selectedQuestion },
                    set: { id in
                        self.stackoverflowStore.questionStore.reload(byId: id);
                        DispatchQueue.main.async {
                            self.selectedQuestion = id
                        }
                    }
                )
            ) {
                EmptyView()
            }
            .hidden()

            questionItem(item, geometry: geometry)
        }
        .listRowInsets(EdgeInsets.zero)
    }
    
    func questionItem(_ item: QuestionItemModel, geometry: GeometryProxy) -> some View {
        VStack(spacing: .zero) {
            if UIDevice.current.userInterfaceIdiom.isPhone {
                QuestionItemView(model: item, globalGeometry: geometry.size)
                    .environmentObject(self.stackoverflowStore)
                    .modifier(PaddingsModifier(
                        orientation: self.transitionStore.deviceOrientation,
                        safeAreaInsets: geometry.safeAreaInsets
                    ))
            } else {
                QuestionItemView(model: item, globalGeometry: geometry.size)
                    .environmentObject(self.stackoverflowStore)
                    .padding(.top, 8)
                    .padding(.horizontal, 16)
                    .background(Color.background)
            }
            Divider()
                .edgesIgnoringSafeArea([.leading, .trailing])
        }
    }
}

// MARK: - Previews

#if DEBUG
struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
            .environmentObject(StackoverflowStore())
            .environment(\.colorScheme, .dark)
    }
}
#endif

// MARK: - Extensions

fileprivate extension Color {
    static let loadMoreForeground = Color("loadMoreForeground")
    static let background = Color("mainBackground")
}

fileprivate extension UIColor {
    static let background = UIColor(named: "mainBackground")
    static let separator = UIColor(named: "separator")
}

// MARK: - View Modifiers

fileprivate struct LazyView<Content: View>: View {
    let build: () -> Content
    
    init(_ build: @autoclosure @escaping () -> Content) {
        self.build = build
    }
    
    var body: Content {
        build()
    }
}

fileprivate struct NavigationViewModifier: ViewModifier {
    func body(content: Content) -> some View {
        Group {
            if UIDevice.current.userInterfaceIdiom.isPhone {
                content
                    .navigationViewStyle(StackNavigationViewStyle())
            } else {
                content
                    .navigationViewStyle(DoubleColumnNavigationViewStyle())
            }
        }
    }
}

fileprivate struct ListEdgesModifier: ViewModifier {
    var orientation: UIDeviceOrientation
    
    func body(content: Content) -> some View {
        guard UIDevice.current.userInterfaceIdiom.isPhone else {
            return content.edgesIgnoringSafeArea([])
        }
        switch orientation {
        case .landscapeLeft, .landscapeRight:
            return content.edgesIgnoringSafeArea([.leading, .trailing])
        default:
            return content.edgesIgnoringSafeArea([])
        }
    }
}

fileprivate struct PaddingsModifier: ViewModifier {
    var orientation: UIDeviceOrientation
    var safeAreaInsets: EdgeInsets
    
    func body(content: Content) -> some View {
        return content
            .padding(.top, 8)
            .padding(
                .leading,
                orientation == .landscapeLeft || orientation == .landscapeRight ? safeAreaInsets.leading + 16 : 16
            )
            .padding(
                .trailing,
                orientation == .landscapeLeft || orientation == .landscapeRight ? safeAreaInsets.trailing + 16 : 16
            )
            .background(Color.background)
    }
}
