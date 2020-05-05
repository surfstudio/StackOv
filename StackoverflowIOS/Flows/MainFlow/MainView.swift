//
//  MainView.swift
//  StackoverflowIOS
//
//  Created by Erik Basargin on 03/05/2020.
//  Copyright © 2020 Ephedra Software. All rights reserved.
//

import SwiftUI

struct MainView: View {
    @EnvironmentObject var stackoverflowStore: StackoverflowStore
    
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
            UITableView.appearance().backgroundColor = .clear
            self.stackoverflowStore.loadQuestions()
        }
    }
    
    var content: some View {
        List {
            ForEach(self.stackoverflowStore.state.content) {
                QuestionItemView(model: $0)
            }
            .listRowBackground(Color.background)
        }
        .padding([.top, .bottom], 0.3)
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
    static let separator = UIColor(named: "separator")
}
