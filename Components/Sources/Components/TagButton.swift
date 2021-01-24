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

    let tag: String
    let action: () -> Void
    
    public init(tag: String, action: @escaping () -> Void) {
        self.tag = tag
        self.action = action
    }
    
    public var body: some View {
        Button(action: action) {
            Text(tag)
        }
        .modifier(TagButtonStyle())
    }
    
    public static func size(for text: String) -> CGSize {
        let tagSize = (text as NSString).size(withAttributes: [.font: UIFont.systemFont(ofSize: 10, weight: .regular)])
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
            .font(.system(size: 10, weight: .regular))
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
