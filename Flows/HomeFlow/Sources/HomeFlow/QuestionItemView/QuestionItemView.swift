//
//  QuestionItemView.swift
//  
//
//  Created by Erik Basargin on 09/10/2020.
//

import SwiftUI
import Palette
import Common
import Components

struct QuestionItemView: View {
    
    typealias BackgroundColor = (top: Color, bottom: Color)
    
    struct Model: Identifiable {
        let colors: QuestionItemView.BackgroundColor
        var id: Int { colors.bottom.hashValue }
    }
    
    let colors: BackgroundColor
    
    let tags: [QuestionTagModel] = ["123", "perfomance", "microsoft-ui-automation", "css", "c++",
                                    "123", "perfomance", "microsoft-ui-automation", "css", "c++"].map { .init(value: $0) }
    
    @State private var hovered = false
    
    init(_ model: Model) {
        self.colors = model.colors
    }

    var body: some View {
        content
            .frame(minWidth: 267, minHeight: 217)
            .background(
                LinearGradient(
                    gradient: Gradient(colors: [colors.top, colors.bottom]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
            )
            .cornerRadius(20)
            .shadow(color: colors.top.opacity(hovered ? 0.2 : 0), radius: 5, x: 5, y: 5)
            .shadow(color: colors.bottom.opacity(hovered ? 0.7: 0), radius: 5, x: -2.5, y: -2.5)
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
            
            Text("How to make TouchableOpacity wrap its content when nested inside parent that has flex = 1; How to make TouchableOpacity wrap its content when nested inside parent that has flex = 1")
                .font(.system(size: 13, weight: .bold))
                .lineLimit(3)
                .fixedSize(horizontal: false, vertical: true)
            
            TagsCollectionView(tags.map { $0.value }, preferredWidth: 235, alignment: .top) { tag in
                TagButton(tag: tag) {
                    print(tag)
                }
            }
        }
    }
    
    var menu: some View {
        HStack(alignment: .top) {
            HStack(spacing: 13) {
                VStack(alignment: .center) {
                    Text("5")
                    Text("answers")
                }
                .padding(EdgeInsets(top: 7, leading: 6, bottom: 7, trailing: 6))
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.white, lineWidth: 0.5)
                )
                
                Text("12 votes")
            }
            
            Spacer()
            
            EllipsisButton {
                print("EllipsisButton")
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
                Text("276")
                    .foregroundColor(Palette.white.opacity(0.7))
                    .font(.system(size: 10, weight: .regular))
            }
            Spacer()
            Text("23 min ago")
                .foregroundColor(Palette.white.opacity(0.7))
                .font(.system(size: 10, weight: .regular))
        }
    }
}

// MARK: - Previews

struct QuestionItemView_Previews: PreviewProvider {
    
    static let colors: QuestionItemView.BackgroundColor = (
        Color(red: 0.471, green: 0.238, blue: 0.704),
        Color(red: 0.276, green: 0.122, blue: 0.438)
    )
    
    static var previews: some View {
        QuestionItemView(.init(colors: colors))
            .padding()
            .background(Color.black)
            .previewLayout(.sizeThatFits)
    }
}

// MARK: - Extensions

fileprivate extension Array where Element == QuestionTagModel {
    
    var sizes: [CGSize] { map { TagButton.size(for: $0.value) } }
}
