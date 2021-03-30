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
    
    // MARK: - Initialization
    
    public init(tag: String, action: @escaping ((_ selectedItem: TagButton.MenuItem) -> Void)) {
        self.tag = tag
        self.action = action
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
        .modifier(TagButtonStyle())
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
    
    func body(content: Content) -> some View {
        content
            .lineLimit(1)
            .foregroundColor(.foreground)
            .padding([.top, .bottom], 3)
            .padding([.leading, .trailing], 10)
            .background(Color.background)
            .cornerRadius(6)
    }
}

// MARK: - Extensions

public extension TagButton.MenuItem {
    
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
    
    var id: Int {
        hashValue
    }
}

// MARK: - Colors

fileprivate extension Color {
    
    static let foreground = Color.white
    static let background = Color.white.opacity(0.1)
}
