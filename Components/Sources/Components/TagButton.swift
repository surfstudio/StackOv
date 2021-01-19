//
//  TagButton.swift
//  This source file is part of the StackOv open source project
//

import SwiftUI
import Palette

public struct TagButton: View {

    let tag: String
    let action: () -> Void
    
    public init(tag: String, action: @escaping () -> Void) {
        self.tag = tag
        self.action = action
    }
    
    public var body: some View {
        Button(action: action) {
            Text(tag)
                .font(.subheadline)
                .fontWeight(.medium)
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
            TagButton(tag: "performance", action: {})
                .padding()
                .previewLayout(.sizeThatFits)
                .environment(\.colorScheme, .light)
            
            TagButton(tag: "performance", action: {})
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
            .buttonStyle(BorderlessButtonStyle())
            .lineLimit(1)
            .foregroundColor(.foreground)
            .padding([.top, .bottom], 3)
            .padding([.leading, .trailing], 10)
            .background(Color.background)
            .cornerRadius(6)
    }
}

// MARK: - Colors

fileprivate extension Color {
    
    static let foreground = Palette.white
    static let background = Palette.white.opacity(0.1)
}
