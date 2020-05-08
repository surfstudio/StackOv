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
        ZStack {
            Color.background.edgesIgnoringSafeArea(.all)
            
            Group { () -> AnyView in
                switch stackoverflowStore.state {
                case .unknown:
                    return AnyView(EmptyView())
                case .emptyContent:
                    return AnyView(emptyContent)
                case .content:
                    return AnyView(content)
                case .loading:
                    return AnyView(loading)
                case .error:
                    return AnyView(error)
                }
            }
        }
        .onAppear {
            UITableView.appearance().separatorColor = .separator
            UITableView.appearance().separatorInset = UIEdgeInsets.zero
            UITableView.appearance().backgroundColor = UIColor.background
            self.stackoverflowStore.loadQuestions()
        }
    }
    
    var content: some View {
        GeometryReader { geometry in
            List {
                ForEach(self.stackoverflowStore.state.content) {
                    QuestionItemView(model: $0)
                        .modifier(QuestionItemPaddingsModifier(
                            orientation: self.transitionStore.deviceOrientation,
                            geometry: geometry
                        ))
                        
                }
                .listRowBackground(Color.background)
            }
        }
        .padding(.top, 0.3)
        .modifier(ListEdgesModifier(orientation: transitionStore.deviceOrientation))
    }
    
    var emptyContent: some View {
        Text("Not found")
    }
    
    var loading: some View {
        Text("Loading")
    }
    
    var error: some View {
        Text(stackoverflowStore.state.error?.localizedDescription ?? "")
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
    var geometry: GeometryProxy
    
    func body(content: Content) -> some View {
        content.listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
            .padding(.top, 8)
            .padding(
                .leading,
                orientation == .landscapeLeft ? geometry.safeAreaInsets.leading : 16
            )
            .padding(
                .trailing,
                orientation == .landscapeRight ? geometry.safeAreaInsets.trailing : 16
            )
            .background(Color.background)
    }
}
