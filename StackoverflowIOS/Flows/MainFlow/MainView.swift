//
//  MainView.swift
//  StackoverflowIOS
//
//  Created by Erik Basargin on 03/05/2020.
//  Copyright © 2020 Ephedra Software. All rights reserved.
//

import SwiftUI
import Combine

struct MainView: View {
    @EnvironmentObject var stackoverflowStore: StackoverflowStore
    @EnvironmentObject var transitionStore: TransitionStore
    
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
                    .environmentObject(self.stackoverflowStore)
                    .disabled(stackoverflowStore.state.isUnknown)
            }
            .navigationBarTitle("")
            .navigationBarHidden(true)
        }
        .onAppear {
            UITableView.appearance().separatorColor = .separator
            UITableView.appearance().separatorInset = UIEdgeInsets.zero
            UITableView.appearance().backgroundColor = UIColor.background
            UITableView.appearance().keyboardDismissMode = .onDrag
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
            List {
                ForEach(self.stackoverflowStore.state.content) { item in
                    self.navigationLink(forItem: item, safeAreaInsets: geometry.safeAreaInsets)
                }
                .listRowBackground(Color.background)
            }
        }
        .modifier(ListEdgesModifier(orientation: transitionStore.deviceOrientation))
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
    
    func navigationLink(forItem item: QuestionItemModel, safeAreaInsets: EdgeInsets) -> some View {
        ZStack {
            questionItem(item, safeAreaInsets: safeAreaInsets)
            NavigationLink(destination: destinationFor(item: item)) {
                EmptyView()
            }
            .hidden()
        }
        .listRowInsets(EdgeInsets.zero)
    }
    
    func questionItem(_ item: QuestionItemModel, safeAreaInsets: EdgeInsets) -> some View {
        QuestionItemView(model: item)
            .environmentObject(self.stackoverflowStore)
            .modifier(QuestionItemPaddingsModifier(
                orientation: self.transitionStore.deviceOrientation,
                safeAreaInsets: safeAreaInsets
            ))
    }
    
    func destinationFor(item: QuestionItemModel) -> some View {
        QuestionDetailsView(item: item)
            .environmentObject(stackoverflowStore)
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
    static let background = Color("mainBackground")
}

fileprivate extension UIColor {
    static let background = UIColor(named: "mainBackground")
    static let separator = UIColor(named: "separator")
}

// MARK: - View Modifiers

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

fileprivate struct QuestionItemPaddingsModifier: ViewModifier {
    var orientation: UIDeviceOrientation
    var safeAreaInsets: EdgeInsets
    
    func body(content: Content) -> some View {
        content
            .padding(.top, 8)
            .padding(
                .leading,
                orientation == .landscapeLeft ? safeAreaInsets.leading : 16
            )
            .padding(
                .trailing,
                orientation == .landscapeRight ? safeAreaInsets.trailing : 16
            )
            .background(Color.background)
    }
}
