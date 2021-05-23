//
//  ThreadItemView.swift
//  StackOv (Components module)
//
//  Created by Evgeny Novgorodov
//  Copyright © 2021 Erik Basargin. All rights reserved.
//

import SwiftUI
import Palette
import Common
import Icons
import Kingfisher

public struct ThreadItemView: View {
    
    // MARK: - States
    
    @Environment(\.sizeCategory) var sizeCategory: ContentSizeCategory
    @Binding var preferredCollectionWidth: CGFloat
    
    // MARK: - Properties
    
    let model: QuestionModel
    
    // MARK: - Initialization
    
    public init (model: QuestionModel, preferredCollectionWidth: Binding<CGFloat>) {
        self.model = model
        self._preferredCollectionWidth = preferredCollectionWidth
    }
    
    // MARK: - View
    
    public var body: some View {
        content
            .background(
                KFImage(model.avatar)
                    .resizable()
                    .blur(radius: 10)
                    .overlay(
                        LinearGradient(
                            gradient: Gradient(colors: [model.gradientColors.top, model.gradientColors.bottom]),
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        ).compositingGroup()
                    )
                    .drawingGroup()
            )
            .frame(
                minWidth: PageConstrants.gridItemMinimumWidth,
                minHeight: PageConstrants.gridItemMaximumHeight)
            .cornerRadius(20)
    }
    
    var content: some View {
        VStack(alignment: .leading, spacing: 0) {
            topContent
            Spacer()
            if !sizeCategory.isAccessibilityCategory {
                bottomContent
            }
        }
        .padding(EdgeInsets.all(ThreadItemConstants.defaultPadding))
    }
    
    var topContent: some View {
        VStack(alignment: .leading, spacing: 12) {
            menu
            
            Text(model.title)
                .font(.body)
                .fontWeight(.bold)
                .foregroundColor(Color.foreground)
                .lineLimit(3)
                .fixedSize(horizontal: false, vertical: true)
            
            if !sizeCategory.isAccessibilityCategory {
                TagsCollectionView(model.tags, alignment: .top, preferredWidth: $preferredCollectionWidth) { tag in
                    TagButton(tag: tag, style: .small) { selectedItem in
                        // TODO: In the future, you will need to process this data
                    }
                }
            }
        }
    }
    
    var menu: some View {
        HStack(alignment: .top) {
            HStack(spacing: 13) {
                ThreadItemInfoView(model: model)
                
                Text(sizeCategory.isAccessibilityCategory
                        ? "\(model.votesNumber)\nvotes"
                        : "\(model.votesNumber) votes")
                    .font(.subheadline)
                    .foregroundColor(Color.foreground)
                    .lineLimit(sizeCategory.isAccessibilityCategory ? 2 : 1)
            }
            
            Spacer()
        }
    }
    
    var bottomContent: some View {
        HStack {
            HStack(spacing: 6) {
                Icons.eyeFill.image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 16, height: 16)
                    .foregroundColor(Color.foreground.opacity(0.5))
                Text("\(model.viewsNumber)")
                    .foregroundColor(Color.foreground.opacity(0.7))
                    .font(.caption)
            }
            
            Spacer()
            
            Text(model.formattedLastActivityDate)
                .foregroundColor(Color.foreground.opacity(0.7))
                .font(.caption)
        }
    }
}

// MARK: - Previews

struct ThreadItemView_Previews: PreviewProvider {
    
    static var previews: some View {
        ThreadItemView(model: QuestionModel.mock(), preferredCollectionWidth: .constant(226))
            .padding()
            .previewLayout(.sizeThatFits)
    }
}

// MARK: - Colors

fileprivate extension Color {
    
    static let foreground = Color.white
}
