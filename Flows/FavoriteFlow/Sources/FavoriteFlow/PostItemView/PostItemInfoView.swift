//
//  PostItemInfoView.swift
//  StackOv (HomeFlow module)
//
//  Created by Evgeny Novgorodov
//  Copyright © 2021 Erik Basargin. All rights reserved.
//

import SwiftUI
import Common

struct PostItemInfoView: View {
    
    // MARK: - Nested types
    
    private enum Constants {
        static let cornerRadius: CGFloat = 10
    }
    
    // MARK: - Properties
    
    let model: QuestionModel
    
    // MARK: - View
    
    var body: some View {
        if model.isEmpty {
            content
                .background(Color.background.opacity(0.1))
                .cornerRadius(Constants.cornerRadius)
        } else if model.hasAcceptedAnswer {
            content
                .background(LinearGradient(
                    gradient: Gradient(colors: [Color.background, Color.background.opacity(0.24)]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                ).opacity(0.1))
                .cornerRadius(Constants.cornerRadius)
        } else {
            content
                .cornerRadius(Constants.cornerRadius)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.border.opacity(0.5), lineWidth: 0.5)
                )
        }
    }
    
    var content: some View {
        VStack(alignment: .center) {
            Text("\(model.answersNumber)")
                .font(.body)
                .fontWeight(.bold)
                .foregroundColor(Color.foreground)
                .lineLimit(1)
                .opacity(model.isEmpty ? 0.5 : 1)
            Text("answers")
                .font(.subheadline)
                .foregroundColor(Color.foreground.opacity(0.7))
                .lineLimit(1)
                .opacity(model.isEmpty ? 0.5 : 1)
        }
        .padding(.horizontal, 6)
        .padding(.vertical, 7)
    }
}

// MARK: - Previews

struct PostItemInfoView_Previews: PreviewProvider {
    
    static var previews: some View {
        PostItemInfoView(model: QuestionModel.mock())
            .padding()
            .previewLayout(.sizeThatFits)
    }
}

// MARK: - Colors

fileprivate extension Color {
    
    static let foreground = Color.white
    static let background = Color.white
    static let border = Color.white
}
