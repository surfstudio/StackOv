//
//  AnswersView.swift
//  StackoverflowIOS
//
//  Created by Erik Basargin on 23/05/2020.
//  Copyright © 2020 Ephedra Software. All rights reserved.
//

import SwiftUI
import HTMLEntities
import Down

struct AnswersView: View {
    @EnvironmentObject var questionStore: QuestionStore
    @EnvironmentObject var answersStore: AnswersStore
    
    var body: some View {
        Group { () -> AnyView in
            switch answersStore.state {
            case .unknown:
                print("Answers store state -> \(answersStore.state)")
                return AnyView(EmptyView())
            case .emptyContent:
                print("Answers store state -> \(answersStore.state)")
                return AnyView(emptyContent)
            case let .content(model):
                print("Answers store state -> \(answersStore.state)")
                return AnyView(content(model))
            case .loading:
                print("Answers store state -> \(answersStore.state)")
                return AnyView(loading)
            case .error:
                print("Answers store state -> \(answersStore.state)")
                return AnyView(error)
            }
        }
        .onReceive(questionStore.$state) { state in
            guard case let .content(model) = state else {
                return
            }
            if let id = model.acceptedAnswerId {
                self.answersStore.loadAnswer(id: id)
            } else {
                self.answersStore.loadAnswers(.reload)
            }
        }
    }
    
    var emptyContent: some View {
        EmptyContentView()
    }
    
    var loading: some View {
        LoadingIndicatorView()
            .frame(width: 30, height: 30)
            .padding(.top)
    }
    
    var error: some View {
        Text(questionStore.state.error?.localizedDescription ?? "")
    }
    
    var sectionHeader: some View {
        VStack(alignment: .leading, spacing: 6) {
            Divider()
            Text("Answers")
                .font(.system(size: 18))
                .fontWeight(.bold)
                .foregroundColor(Color.title)
                .padding(.top, 6)
            Divider()
        }
        .padding(.bottom)
    }
    
    func content(_ model: [AnswerModel]) -> some View {
        print("Set new content")
        return VStack(alignment: .leading, spacing: .zero) {
            sectionHeader
                .padding(.horizontal, 16)
            ForEach(model) {
                AnswerView(model: $0)
            }
        }
    }
}

// MARK: - Previews

#if DEBUG
struct AnswersView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            AnswersView()
                .padding()
                .previewLayout(.sizeThatFits)
                .background(Color.background)
                .environment(\.colorScheme, .light)
                .environmentObject(QuestionStore())
            
            AnswersView()
                .padding()
                .previewLayout(.sizeThatFits)
                .background(Color.background)
                .environment(\.colorScheme, .dark)
                .environmentObject(QuestionStore())
        }
    }
}
#endif

// MARK: - Extensions

fileprivate extension Color {
    static let title = Color("questionTitle")
    #if DEBUG
    static let background = Color("mainBackground")
    #endif
}
