//
//  PhoneQuestionView.swift
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

struct PhoneQuestionView: View {
    
    // MARK: - Properties
    
    var model: QuestionModel
    
    // MARK: - Views
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack(alignment: .top, spacing: 0) {
                RetingView(viewed: model.formattedVotesNumber)
                    .padding(EdgeInsets(top: 0, leading: 8, bottom: 0, trailing: 28))
                VStack(alignment: .leading, spacing: 0) {
                    Text(model.title)
                        .font(.title3)
                        .fontWeight(.bold)
                    
                    Text("Asked \(model.timeHasPassedSinceCreation)")
                        .foregroundColor(Color.subheadings)
                        .padding(.top, 16)
                        .font(.caption)

                    HStack(spacing: 20) {
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
                    .padding(.top, 10)
                    
                }
            }
            Divider()
                .padding(.top, 10)
            MarkdownPostView(text: .constant(model.body))
        }
    }

}

// MARK: - Previews

struct PhoneQuestionView_Previews: PreviewProvider {
    static var previews: some View {
        PhoneQuestionView(model: QuestionModel.mock())
    }
}

// MARK: - Colors

fileprivate extension Color {
    
    static var subheadings: Color = Palette.slateGray | Color.white.opacity(0.7)
    static var text: Color = Palette.black | .white

}
