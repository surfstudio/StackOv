//
//  TagFilter.swift
//  This source file is part of the StackOv open source project
//

import SwiftUI
import Palette

public struct TagFilter: View {

    let tag: String
    @Binding var selected: String
    
    public init(tag: String, state: Binding<String>) {
        self.tag = tag
        self._selected = state
    }

    public var body: some View {
        Button(action: { selected = tag }) {
            Text(tag)
        }
        .modifier(TagFilterStyle())
        .background(Color.background(by: selected == tag))
        .disabled(selected == tag)
    }
}

// MARK: - Previews

struct TagFilter_Previews: PreviewProvider {
    
    static var previews: some View {
        Group {
            TagFilter(tag: "performance", state: .constant("123"))
                .padding()
                .previewLayout(.sizeThatFits)
                .environment(\.colorScheme, .light)
            
            TagFilter(tag: "performance", state: .constant("performance"))
                .padding()
                .previewLayout(.sizeThatFits)
                .environment(\.colorScheme, .dark)
        }
    }
}

// MARK: - View Modifiers

fileprivate struct TagFilterStyle: ViewModifier {
    
    func body(content: Content) -> some View {
        content
            .buttonStyle(BorderlessButtonStyle())
            .font(.system(size: 12, weight: .regular))
            .lineLimit(1)
            .foregroundColor(.foreground)
            .padding([.top, .bottom], 4.5)
            .padding([.leading, .trailing], 10)
            .cornerRadius(6)
    }
}

// MARK: - Colors

fileprivate extension Color {
    
    static let foreground = Palette.white
    static let background = Palette.white.opacity(0.1)
    static func background(by selected: Bool) -> Color {
        selected ? .main : .background
    }
}
