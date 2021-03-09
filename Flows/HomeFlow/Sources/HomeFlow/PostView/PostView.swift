//
//  PostView.swift
//  This source file is part of the StackOv open source project
//

import SwiftUI
import Palette
import Common
import Components
import Icons
import AppScript
import struct PageStore.QuestionModel

struct PostView: View {
    
    // MARK: - States

    @EnvironmentObject var store: PostStore
    
    // MARK: - Properties
    
    var contentEdgeInsets: EdgeInsets {
        UIDevice.current.userInterfaceIdiom.isPad
            ? EdgeInsets(top: 18, leading: 18, bottom: 18, trailing: 18)
            : EdgeInsets(top: 12, leading: 12, bottom: 12, trailing: 12)
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

struct PostView_Previews: PreviewProvider {
    
    static var previews: some View {
        PostView()
    }
}

// MARK: - Colors

fileprivate extension Color {
    
    static let background = Palette.bluishblack
}

fileprivate extension UIColor {
    
    static let foreground = PaletteCore.dullGray
    static let background = PaletteCore.bluishblack
    static let navigationBackground = PaletteCore.grayblue.withAlphaComponent(0.5).rgbaToRgb(by: .background)
}
