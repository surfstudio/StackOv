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
    
    // MARK: - States

    @Environment(\.sizeCategory) var sizeCategory
    @Environment(\.horizontalSizeClass) var horizontalSizeClass

    @Store var sidebarStore: SidebarStore
    
    // MARK: - Properties
    
    var model: QuestionModel
    
    // MARK: - Views
    
    var body: some View {
        VStack(alignment: .leading) {
            header
            Divider()
                .padding(.top, 10)
            MarkdownPostView(text: .constant(model.body))
            tags
            footer
        }
    }
    
    var header: some View {
        HStack(alignment: .top, spacing: 0) {
            RetingView(viewed: model.formattedVotesNumber, isVertical: true)
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
    }
    
    var tags: some View {
        AdaptiveTagsCollectionView(model.tags, alignment: .top) { tag in
            TagButton(tag: tag, style: .large) { selectedItem in
                // TODO: In the future, you will need to process this data
            }
        } prepareCollectionWidth: { mainContentWidth in
            let inset = ThreadFlowScreenConfiguration.horisontalInset(horizontalSizeClass: horizontalSizeClass)
            return mainContentWidth - inset * 2
        }
    }
    
    var footer: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack(alignment: .center, spacing: 24) {
                Button("Share") {
                    // TODO: Add functionality in the future
                }

                Button("Edit") {
                    // TODO: Add functionality in the future
                }

                Button("Follow") {
                    // TODO: Add functionality in the future
                }
                
                Spacer()

                if model.comments.count == 0 {
                    Button("Add comment") {
                        // TODO: Add functionality in the future
                    }
                }
            }
            .padding(.vertical, 12)
            .font(.subheadline)
            .foregroundColor(Palette.main)
            
            PersonInfoView(model: UserModel.mock(), indent: 12, isFullScreen: true)
            PersonInfoView(model: UserModel.mock(), indent: 12, isFullScreen: true)
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
