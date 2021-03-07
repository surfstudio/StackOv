//
//  PostItemView.swift
//  StackOv (HomeFlow module)
//
//  Created by Erik Basargin
//  Copyright © 2021 Erik Basargin. All rights reserved.
//

import SwiftUI
import Palette
import Common
import Components
import struct PageStore.QuestionModel

struct PostItemView: View {

    // MARK: - States
    
    @Environment(\.sizeCategory) var sizeCategory: ContentSizeCategory
    @State private var hovered = false
    
    // MARK: - Properties
    
    let model: QuestionModel

    // MARK: - View
    
    var body: some View {
        content
            .frame(minWidth: 267, minHeight: 217)
            .background(
                LinearGradient(
                    gradient: Gradient(colors: [model.gradientColors.top, model.gradientColors.bottom]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
            )
            .cornerRadius(20)
            .shadow(color: model.gradientColors.top.opacity(hovered ? 0.2 : 0), radius: 5, x: 5, y: 5)
            .shadow(color: model.gradientColors.bottom.opacity(hovered ? 0.7: 0), radius: 5, x: -2.5, y: -2.5)
            .animation(.default)
            .onHover { isHovered in
                self.hovered = isHovered
            }
    }
    
    var content: some View {
        VStack(alignment: .leading, spacing: 0) {
            topContent
            Spacer()
            if !sizeCategory.isAccessibilityCategory {
                bottomContent
            }
        }
        .padding(EdgeInsets.all(16))
    }
    
    var topContent: some View {
        VStack(alignment: .leading, spacing: 12) {
            menu
            
            Text(model.title)
                .font(.body)
                .fontWeight(.bold)
                .lineLimit(3)
                .fixedSize(horizontal: false, vertical: true)
            
            if !sizeCategory.isAccessibilityCategory {
                TagsCollectionView(model.tags, preferredWidth: 267, alignment: .top) { tag in
                    TagButton(tag: tag) {
                        // TODO: - Issue #38
                    }
                }
            }
        }
    }
    
    var menu: some View {
        HStack(alignment: .top) {
            HStack(spacing: 13) {
                PostItemInfoView(model: model)
                if sizeCategory.isAccessibilityCategory {
                    Text("\(model.votesNumber)\nvotes")
                        .font(.subheadline)
                        .lineLimit(2)
                } else {
                    Text("\(model.votesNumber) votes")
                        .font(.subheadline)
                        .lineLimit(1)
                }
            }
            
            Spacer()
        }
    }
    
    var bottomContent: some View {
        HStack {
            HStack(spacing: 6) {
                Image(systemName: "eye.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 16, height: 16)
                    .foregroundColor(Color.white.opacity(0.5))
                Text("\(model.viewsNumber)")
                    .foregroundColor(Color.white.opacity(0.7))
                    .font(.caption)
            }
            
            Spacer()
            
            Text(model.formattedLastActivity)
                .foregroundColor(Color.white.opacity(0.7))
                .font(.caption)
        }
    }
}

// MARK: - Previews

struct QuestionItemView_Previews: PreviewProvider {
    
    static var previews: some View {
        PostItemView(model: QuestionModel.mock())
            .padding()
            .background(Color.black)
            .previewLayout(.sizeThatFits)
    }
}
