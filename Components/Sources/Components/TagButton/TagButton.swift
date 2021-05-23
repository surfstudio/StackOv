//
//  TagButton.swift
//  StackOv (Components module)
//
//  Created by Erik Basargin
//  Copyright © 2021 Erik Basargin. All rights reserved.
//

import SwiftUI
import Palette

public struct TagButton: View {
    
    // MARK: - Nested types
    
    public enum Style: Comparable {
        case small
        case large
    }
    
    public enum MenuItem: Identifiable, CaseIterable {
        case addTagToFilter
        case watchUnwatchTag
        case ignoreTag
        case copyTag
    }
    
    // MARK: - Properties
    
    let tag: String
    let action: (_ selectedItem: TagButton.MenuItem) -> Void
    let style: Style
    
    // MARK: - Initialization
    
    public init(tag: String, style: Style, action: @escaping ((_ selectedItem: TagButton.MenuItem) -> Void)) {
        self.tag = tag
        self.action = action
        self.style = style
    }
    
    // MARK: - View
    
    public var body: some View {
        Button(action: {}) {
            Menu {
                ForEach(MenuItem.allCases) { menuItem in
                    Button(menuItem.title) { action(menuItem) }
                }
            } label: {
                Text(tag)
                    .font(.subheadline)
                    .fontWeight(.medium)
            }
        }
        .modifier(TagButtonStyleModifier(style: style))
    }
    
    public static func size(for text: String, style: TagButton.Style) -> CGSize {
        let font = UIFontMetrics(forTextStyle: .subheadline)
            .scaledFont(for: UIFont.systemFont(ofSize: 15, weight: .medium))
        let tagSize = (text as NSString).size(withAttributes: [.font: font])
        switch style {
        case .small:
            return CGSize(width: 20 + ceil(tagSize.width), height: 6 + ceil(tagSize.height))
        case .large:
            return CGSize(width: 20 + ceil(tagSize.width), height: 12 + ceil(tagSize.height))
        }
    }
}

// MARK: - Previews

struct TagButton_Previews: PreviewProvider {
    
    static var previews: some View {
        Group {
            TagButton(tag: "performance", style: .small, action: { _ in })
                .padding()
                .previewLayout(.sizeThatFits)
                .environment(\.colorScheme, .light)
            
            TagButton(tag: "performance", style: .large, action: { _ in })
                .padding()
                .previewLayout(.sizeThatFits)
                .environment(\.colorScheme, .dark)
        }
    }
}

// MARK: - View Modifiers

fileprivate struct SmallTagButtonStyle: ButtonStyle {
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .lineLimit(1)
            .foregroundColor(Color.foreground(style: .small))
            .padding([.top, .bottom], 3)
            .padding([.leading, .trailing], 10)
            .background(Color.background(style: .small))
            .cornerRadius(6)
    }
}

fileprivate struct LargeTagButtonStyle: ButtonStyle {
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .lineLimit(1)
            .foregroundColor(Color.foreground(style: .large))
            .padding([.top, .bottom], 6)
            .padding([.leading, .trailing], 10)
            .background(Color.background(style: .large))
            .cornerRadius(6)
    }
}

fileprivate struct TagButtonStyleModifier: ViewModifier {
    
    // MARK: - Properties
    
    let style: TagButton.Style
    
    // MARK: - View
    
    @ViewBuilder
    func body(content: Content) -> some View {
        switch style {
        case .small:
            content
                .buttonStyle(SmallTagButtonStyle())
        case .large:
            content
                .buttonStyle(LargeTagButtonStyle())
        }
    }
}

// MARK: - Extensions

public extension TagButton.MenuItem {
    
    var id: Int {
        hashValue
    }
}

fileprivate extension TagButton.MenuItem {
    
    var title: String {
        switch self {
        case .addTagToFilter:
            return "Add tag to filter"
        case .watchUnwatchTag:
            return "Watch tag"
        case .ignoreTag:
            return "Ignore tag"
        case .copyTag:
            return "Copy tag"
        }
    }
}

// MARK: - Colors

fileprivate extension Color {
    
    static func foreground(style: TagButton.Style) -> Color {
        style == .large
            ? Palette.main | Color.white
            : Color.white
    }
    
    static func background(style: TagButton.Style) -> Color {
        style == .large
            ? Palette.main.opacity(0.12) | Color.white.opacity(0.08)
            : Color.white.opacity(0.1)
    }
}
