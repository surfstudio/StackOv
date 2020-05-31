//
//  QuestionView.swift
//  StackoverflowIOS
//
//  Created by Erik Basargin on 16/05/2020.
//  Copyright © 2020 Ephedra Software. All rights reserved.
//

import SwiftUI
import HTMLEntities
import Down

struct QuestionView: View {
    @EnvironmentObject var questionStore: QuestionStore
    
    var body: some View {
        Group { () -> AnyView in
            switch questionStore.state {
            case .unknown:
                return AnyView(EmptyView())
            case .emptyContent:
                return AnyView(emptyContent)
            case let .content(model):
                return AnyView(content(model))
            case .loading:
                return AnyView(loading)
            case .error:
                return AnyView(error)
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
    
    func content(_ model: QuestionModel) -> some View {
        VStack(alignment: .leading, spacing: .zero) {
            Text(model.title)
                .font(.system(size: 18))
                .fontWeight(.bold)
                .foregroundColor(Color.title)
                .lineLimit(nil)
                .padding(.top, 8)
                .fixedSize(horizontal: false, vertical: true)
            
            Divider()
                .padding(.vertical, 6)
            
            MarkdownView(text: .constant(model.body.htmlUnescape()))
            
            TagsCollectionView(model.tags) { tag in
                TagView(tag: tag.name) {
//                    self.stackoverflowStore.searchStore.search(tag: tag)
                }
            }
            .padding(.top)
        }
        // https://stackoverflow.com/questions/61910373/how-to-multiply-certain-columns-fields-in-a-large-array-of-objects
    }
}

// MARK: - Previews

#if DEBUG
struct QuestionView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            QuestionView()
                .padding()
                .previewLayout(.sizeThatFits)
                .background(Color.background)
                .environment(\.colorScheme, .light)
                .environmentObject(QuestionStore())
            
            QuestionView()
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
