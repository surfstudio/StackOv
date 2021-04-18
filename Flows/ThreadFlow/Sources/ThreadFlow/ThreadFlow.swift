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

public struct ThreadFlow: View {
    
    // MARK: - States
    
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    @EnvironmentObject var store: ThreadStore
    @Store private var sidebarStore: SidebarStore
    
    // MARK: - Properties
    
    var contentEdgeInsets: EdgeInsets {
        let horisontal: CGFloat = UIDevice.current.userInterfaceIdiom.isPad && horizontalSizeClass == .regular ? 60 : 20
        let vertical: CGFloat = UIDevice.current.userInterfaceIdiom.isPad ? 18 : 12
        return .init(top: vertical, leading: horisontal, bottom: vertical, trailing: horisontal)
    }
    
    // MARK: - Initialization
         
    public init() {}

    // MARK: - View
    
    public var body: some View {
        ZStack {
            Color.background
                .edgesIgnoringSafeArea(.all)
            
            ScrollView {
                VStack(spacing: 0) {
                    QuestionView(model: store.questionModel)
                    
                    switch store.state {
                    case .unknown:
                        Text("").onAppear {
                            store.firstReloadAnswers()
                        }
                    case .emptyContent:
                        Text("empty")
                    case let .content(totalAnswersNumber, models):
                        content(answersNumber: totalAnswersNumber, models: models)
                    case .loading:
                        Text("Loading")
                    case .error:
                        Text("error")
                    }
                    
                    if store.loadMore {
                        LoaderView()
                            .frame(width: 24, height: 24)
                            .padding(.vertical, 20)
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
    
    func content(answersNumber: Int, models: [AnswerModel]) -> some View {
        VStack(spacing: .zero) {
            HStack {
                Text("\(answersNumber) Answers")
                Spacer()
            }.frame(height: 60)
            
            LazyVStack(spacing: .zero) {
                ForEach(models) { item in
                    MarkdownPostView(text: .constant(item.body ?? "")).onAppear {
                        if item == models.last {
                            store.loadNextAnswers()
                        }
                    }
                    
                    if item != models.last {
                        Divider().padding(.vertical, 32)
                    }
                }
            }
        }
    }

}

// MARK: - Previews

struct ThreadFlow_Previews: PreviewProvider {
    
    static var previews: some View {
        ThreadFlow()
            .environmentObject(StoresAssembler.shared.resolve(ThreadStore.self, argument: QuestionModel.mock())!)
    }
}

// MARK: - Colors

fileprivate extension Color {
    
    static let background = Palette.bluishwhite | Palette.bluishblack
}

