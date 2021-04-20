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
    
    public enum MenuItem: Identifiable, CaseIterable {
        case addTagToFilter
        case watchUnwatchTag
        case ignoreTag
        case copyTag
    }
    
    // MARK: - Properties
    
    let tag: String
    let action: (_ selectedItem: TagButton.MenuItem) -> Void
    let isAdaptColor: Bool
    
    // MARK: - Initialization
    
    public init(tag: String, isAdaptColor: Bool = false, action: @escaping ((_ selectedItem: TagButton.MenuItem) -> Void)) {
        self.tag = tag
        self.action = action
        self.isAdaptColor = isAdaptColor
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
        .modifier(TagButtonStyle(isAdaptColor: isAdaptColor))
    }
    
    public static func size(for text: String) -> CGSize {
        let trait = UITraitCollection(preferredContentSizeCategory: .medium)
        let tagSize = (text as NSString).size(
            withAttributes: [.font: UIFont.preferredFont(forTextStyle: .subheadline, compatibleWith: trait)]
        )
        return CGSize(width: ceil(20 + tagSize.width), height: ceil(6 + tagSize.height))
    }
}

// MARK: - Previews

struct TagButton_Previews: PreviewProvider {
    
    static var previews: some View {
        Group {
            TagButton(tag: "performance", action: { _ in })
                .padding()
                .previewLayout(.sizeThatFits)
                .environment(\.colorScheme, .light)
            
            TagButton(tag: "performance", action: { _ in })
                .padding()
                .previewLayout(.sizeThatFits)
                .environment(\.colorScheme, .dark)
        }
    }
}

// MARK: - View Modifiers

fileprivate struct TagButtonStyle: ViewModifier {
    
    // MARK: - Properties
    
    let isAdaptColor: Bool
    
    // MARK: - View
    
    func body(content: Content) -> some View {
        content
            .lineLimit(1)
            .foregroundColor(Color.foreground(isAdaptColor: isAdaptColor))
            .padding([.top, .bottom], 3)
            .padding([.leading, .trailing], 10)
            .background(Color.background(isAdaptColor: isAdaptColor))
            .cornerRadius(6)
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
    
    static func foreground(isAdaptColor: Bool) -> Color {
        isAdaptColor ? Palette.main | Color.white : Color.white
    }
    
    static func background(isAdaptColor: Bool) -> Color {
        isAdaptColor ? Palette.main.opacity(0.12) | Color.white.opacity(0.08) : Color.white.opacity(0.1)
    }
}
