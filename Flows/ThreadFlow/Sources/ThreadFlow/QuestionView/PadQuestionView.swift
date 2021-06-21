//
//  PadQuestionView.swift
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

struct PadQuestionView: View {

    // MARK: - Properties
    
    let model: QuestionModel

    // MARK: - Views
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            header
            Divider()
                .padding(.top, 4)
            content
//            tags
            footer
        }
    }
    
    var header: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text(model.title)
                .font(.title2)
                .fontWeight(.bold)
            
            HStack(spacing: 24) {
                Text("Asked \(model.timeHasPassedSinceCreation)")
                    .foregroundColor(Color.subheadings)

                Text("Active ")
                    .foregroundColor(Color.subheadings)
                    + Text(model.timeHasPassedSinceLastActivity)
                        .foregroundColor(Color.text)

                Text("Viewed ")
                    .foregroundColor(Color.subheadings)
                    + Text ("\(model.formattedViewsNumber) times")
                        .foregroundColor(Color.text)
            }
            .font(.caption)
        }
    }
    
    var content: some View {
        HStack(alignment: .top, spacing: .zero) {
            RetingView(viewed: model.formattedViewsNumber, isVertical: true)
                .padding(.trailing, 34)

            MarkdownPostView(text: .constant(model.body))
        }
    }
    
    var footer: some View {
        HStack(alignment: .center, spacing: 24) {
            Group {
                Button("Share") {
                    // TODO: Add functionality in the future
                }

                Button("Edit") {
                    // TODO: Add functionality in the future
                }

                Button("Follow") {
                    // TODO: Add functionality in the future
                }

                if model.comments.count == 0 {
                    Button("Add comment") {
                        // TODO: Add functionality in the future
                    }
                }
            }
            .font(.subheadline)
            .foregroundColor(Palette.main)
            .lineLimit(1)
            
            Spacer()
            
            PersonInfoView(model: UserModel.mock())
                .fixedSize(horizontal: true, vertical: false)
            PersonInfoView(model: UserModel.mock())
                .fixedSize(horizontal: true, vertical: false)

        }
    }
    
}

// MARK: - Previews

struct PadQuestionView_Previews: PreviewProvider {
    
    static var previews: some View {
        PadQuestionView(model: QuestionModel.mock())
    }
}

// MARK: - Colors

fileprivate extension Color {
    
    static var subheadings: Color = Palette.slateGray | Color.white.opacity(0.7)
    static var text: Color = Palette.black | .white
}
