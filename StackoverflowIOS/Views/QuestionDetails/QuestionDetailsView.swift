//
//  QuestionDetailsView.swift
//  StackoverflowIOS
//
//  Created by Erik Basargin on 16/05/2020.
//  Copyright © 2020 Ephedra Software. All rights reserved.
//

import SwiftUI

struct QuestionDetailsView: View {
    @EnvironmentObject var stackoverflowStore: StackoverflowStore
    
    let questionItem: QuestionItemModel
    
    init(item: QuestionItemModel) {
        questionItem = item
    }
    
    var body: some View {
        ZStack(alignment: .top) {
            Color.background
                .edgesIgnoringSafeArea(.all)
            
            GeometryReader { geometry in
                ScrollView(.vertical) {
                    VStack {
                        QuestionView()
                            .padding(.horizontal, 16)
                            .environmentObject(self.stackoverflowStore.questionStore)
                        
                        AnswersView()
                            .environmentObject(self.stackoverflowStore.questionStore)
                            .environmentObject(self.stackoverflowStore.answersStore)
                        
                        Color.clear
                            .frame(height: geometry.safeAreaInsets.bottom)
                    }
                    .frame(width: geometry.size.width)
                }
                .padding(.top, NavigationBarView.Constants.height)
            }
            
            NavigationBarView()
                .edgesIgnoringSafeArea([.leading, .trailing])
                .environmentObject(self.stackoverflowStore)
        }
        .navigationBarTitle("")
        .navigationBarHidden(true)
        .onAppear {
            self.stackoverflowStore.questionStore.reload(forQuestionId: self.questionItem.id)
            self.stackoverflowStore.answersStore.reload()
            self.stackoverflowStore.questionStore.loadQuestion(id: self.questionItem.id) // 61979056 // 61978105
        }
    }
}

// MARK: - Previews

#if DEBUG
struct QuestionDetailsView_Previews: PreviewProvider {
    static let model = QuestionItemModel(id: 56892691, title: "", isAnswered: false, viewCount: 0, answerCount: 0, score: 0, tags: [], link: URL(string: "google.com")!)
    static var previews: some View {
        Group {
            QuestionDetailsView(item: model)
                .padding()
                .previewLayout(.sizeThatFits)
                .background(Color.background)
                .environment(\.colorScheme, .light)
                .environmentObject(StackoverflowStore())
            
            QuestionDetailsView(item: model)
                .padding()
                .previewLayout(.sizeThatFits)
                .background(Color.background)
                .environment(\.colorScheme, .dark)
                .environmentObject(StackoverflowStore())
        }
    }
}
#endif

// MARK: - Extensions

fileprivate extension Color {
    static let background = Color("mainBackground")
}
