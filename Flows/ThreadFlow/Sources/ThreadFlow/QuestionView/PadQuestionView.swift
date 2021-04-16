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
            tags
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
            RetingView(viewed: model.formattedViewsNumber)
                .padding(.trailing, 34)

            PostView(model: PostModel.from(model: model))
        }
    }
    
    var tags: some View {
        GeometryReader { frame in
            TagsCollectionView(model.tags, preferredWidth: frame.size.width, alignment: .top) { tag in
                TagButton(tag: tag) { selectedItem in
                    // TODO: In the future, you will need to process this data
                }
            }
        }
    }
    
    var footer: some View {
        HStack(alignment: .center, spacing: 20) {
            Button("Share") {
                // TODO: Add functionality in the future
            }
            .font(.headline)
            .foregroundColor(Palette.main)
            .padding(.trailing, 4)
            Button("Edit") {
                // TODO: Add functionality in the future
            }
            .padding(.trailing, 4)
            .font(.headline)
            .foregroundColor(Palette.main)
            Button("Follow") {
                // TODO: Add functionality in the future
            }
            .font(.headline)
            .foregroundColor(Palette.main)
            
            Spacer()
            
            PersonInfoView(model: PersonInfoModel.mock())
            PersonInfoView(model: PersonInfoModel.mock())
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
