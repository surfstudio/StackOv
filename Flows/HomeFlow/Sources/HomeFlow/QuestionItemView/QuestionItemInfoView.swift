//
//  QuestionItemInfoView.swift
//  This source file is part of the StackOv open source project
//

import SwiftUI

struct QuestionItemInfoView: View {
    
    // MARK: - Nested types
    
    private enum Constants {
        static let cornerRadius: CGFloat = 10
    }
    
    // MARK: - Properties
    
    let model: QuestionItemViewModel
    
    // MARK: - View
    
    var body: some View {
        if model.isEmpty {
            content
                .background(Color.white.opacity(0.1))
                .cornerRadius(Constants.cornerRadius)
        } else if model.hasAcceptedAnswer {
            content
                .background(LinearGradient(
                    gradient: Gradient(colors: [Color.white, Color.white.opacity(0.24)]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                ).opacity(0.1))
                .cornerRadius(Constants.cornerRadius)
        } else {
            content
                .cornerRadius(Constants.cornerRadius)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.white.opacity(0.5), lineWidth: 0.5)
                )
        }
    }
    
    var content: some View {
        VStack(alignment: .center) {
            Text("\(model.answersNumber)")
                .font(.subheadline)
                .fontWeight(.bold)
                .opacity(model.isEmpty ? 0.5 : 1)
            Text("answers")
                .font(.footnote)
                .opacity(model.isEmpty ? 0.5 : 1)
        }
        .padding(.horizontal, 6)
        .padding(.vertical, 7)
    }
}
