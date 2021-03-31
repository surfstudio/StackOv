//
//  ThreadView.swift
//  StackOv (ThreadFlow module)
//
//  Created by Владислав Климов
//  Copyright © 2021 Erik Basargin. All rights reserved.
//

import SwiftUI
import Palette
import Common
import Components
import Icons
import AppScript

struct ThreadView: View {
    
    // MARK: - States
    
    @EnvironmentObject var store: ThreadStore
    @Store private var sidebarStore: SidebarStore
    
    // MARK: - Properties
    
    var contentEdgeInsets: EdgeInsets {
        .all(UIDevice.current.userInterfaceIdiom.isPad ? 18 : 12)
    }
    
    // MARK: - View
    
    var body: some View {
        ZStack {
            Color.background
                .edgesIgnoringSafeArea(.all)
            
            ScrollView {
                LazyVStack(spacing: 0) {
                    QuestionView(model: store.questionModel)
                    
                    switch store.state {
                    case .unknown:
                        Text("")
                            .onAppear {
                                store.loadAnswers()
                            }
                    case .emptyContent:
                        Text("empty")
                    case let .content(_):
                        content
                    case .loading:
                        Text("Loading")
                    case .error:
                        Text("error")
                    }
                }
                .padding(contentEdgeInsets)
            }
        }
        .navigationBarTitle("", displayMode: .inline)
        .padToolbar {
            ToolbarItemGroup(placement: .navigationBarLeading) {
                SidebarLeftButton()
            }
        }
        .toolbar {
            #if DEBUG
            ToolbarItemGroup(placement: .navigationBarTrailing) {
                Button(action: {}) {
                    HStack {
                        Text("748")
                            .font(.caption)
                        Image(.bookmark)
                    }
                }.frame(height: 20)
                Button(action: {}, icon: .bell)
                    .frame(width: 20, height: 20)
            }
            #endif
        }
    }
    
    var content: some View {
        EmptyView()
    }
}

// MARK: - Previews

struct ThreadView_Previews: PreviewProvider {
    
    static var previews: some View {
        ThreadView()
    }
}

// MARK: - Colors

fileprivate extension Color {
    
    static let background = Palette.bluishwhite | Palette.bluishblack
}

