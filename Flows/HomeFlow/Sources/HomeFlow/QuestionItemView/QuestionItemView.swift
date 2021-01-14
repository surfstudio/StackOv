//
//  QuestionItemView.swift
//  This source file is part of the StackOv open source project
//

import SwiftUI
import Palette
import Common
import Components

struct QuestionItemView: View {
    
    // MARK: - Nested types
    
    typealias Model = QuestionItemViewModel

    // MARK: - States
    
    @State private var hovered = false
    
    // MARK: - Properties
    
    let model: QuestionItemViewModel

    // MARK: - View
    
    var body: some View {
        content
            .frame(minWidth: 267, minHeight: 217)
            .background(
                LinearGradient(
                    gradient: Gradient(colors: model.backgroundColorsList),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
            )
            .cornerRadius(20)
            .shadow(color: model.backgroundColors.top.opacity(hovered ? 0.2 : 0), radius: 5, x: 5, y: 5)
            .shadow(color: model.backgroundColors.bottom.opacity(hovered ? 0.7: 0), radius: 5, x: -2.5, y: -2.5)
            .animation(.default)
            .onHover { isHovered in
                self.hovered = isHovered
            }
    }
    
    var content: some View {
        VStack(alignment: .leading, spacing: 0) {
            topContent
            Spacer()
            bottomContent
        }
        .padding(EdgeInsets.all(16))
    }
    
    var topContent: some View {
        VStack(alignment: .leading, spacing: 12) {
            menu
            
            Text(model.title)
                .font(.footnote)
                .fontWeight(.bold)
                .lineLimit(3)
                .fixedSize(horizontal: false, vertical: true)
            
            TagsCollectionView(model.tags, preferredWidth: 235, alignment: .top) { tag in
                TagButton(tag: tag) {
                    // TODO: - Need to add a logic
                }
            }
        }
    }
    
    var menu: some View {
        HStack(alignment: .top) {
            HStack(spacing: 13) {
                QuestionItemInfoView(model: model)
                Text("\(model.votesNumber) votes")
                    .font(.footnote)
            }
            
            Spacer()
            
            EllipsisButton {
                // TODO: - Need to add a logic
            }
        }
    }
    
    var bottomContent: some View {
        HStack {
            HStack(spacing: 6) {
                Image(systemName: "eye.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 16, height: 16)
                    .foregroundColor(Palette.white.opacity(0.5))
                Text("\(model.viewsNumber)")
                    .foregroundColor(Palette.white.opacity(0.7))
                    .font(.system(size: 10, weight: .regular))
            }
            
            Spacer()
            
            Text(model.formattedLastUpdate)
                .foregroundColor(Palette.white.opacity(0.7))
                .font(.system(size: 10, weight: .regular))
        }
    }
}

// MARK: - Previews

struct QuestionItemView_Previews: PreviewProvider {
    
    static let colors: [Color] = [
        Color(red: 0.471, green: 0.238, blue: 0.704),
        Color(red: 0.276, green: 0.122, blue: 0.438)
    ]
    
    static var previews: some View {
        let model = QuestionItemViewModel(
            id: 0,
            title: "How to make TouchableOpacity wrap its content when nested inside parent that has flex = 1",
            hasAcceptedAnswer: true,
            answersNumber: 5,
            votesNumber: 15,
            viewsNumber: 207,
            lastUpdateType: .asked(Date()),
            backgroundColors: (top: colors.first!, bottom: colors.last!),
            tags: ["123", "perfomance", "microsoft-ui-automation", "css", "c++",
                   "123", "perfomance", "microsoft-ui-automation", "css", "c++"]
        )
        QuestionItemView(model: model)
            .padding()
            .background(Color.black)
            .previewLayout(.sizeThatFits)
    }
}
