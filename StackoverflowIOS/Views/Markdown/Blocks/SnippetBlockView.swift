//
//  SnippetBlockView.swift
//  StackoverflowIOS
//
//  Created by Erik Basargin on 21/05/2020.
//  Copyright © 2020 Ephedra Software. All rights reserved.
//

import SwiftUI

extension Markdown {
    
    struct SnippetBlockView: MarkdownUnitView {
        let unit: Unit
        
        var body: some View {
            guard case let .snippetBlock(_, code) = unit.type else {
                return AnyView(EmptyView())
            }
            return AnyView(content(code))
        }
        
        private func content(_ code: String) -> some View {
            ScrollView(.horizontal, showsIndicators: true) {
                Text(code)
                    .font(.custom("Menlo-Regular", size: 13))
                    .foregroundColor(.foreground)
                    .fixedSize(horizontal: false, vertical: true)
            }
            .padding([.leading, .top, .trailing], 12)
            .padding(.bottom, 0.3)
            .background(Color.background)
            .cornerRadius(6)
            .padding(.all, 12)
            .border(Color.border)
        }
    }
    
}

// MARK: - Previews

#if DEBUG
struct SnippetBlockView_Previews: PreviewProvider {
    static let unit = Markdown.Unit("""
    <!-- begin snippet: js hide: false console: true babel: false -->
    <!-- language: lang-html -->
    ```
    func convertHtml() -> NSAttributedString {
        guard let data = data(using: .utf8) else { return NSAttributedString() }
        if let attributedString = try? NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html], documentAttributes: nil) {
            return attributedString
        } else {
            return NSAttributedString()
        }
    }
    ```
    <!-- end snippet -->
    """)!.children.first!
    static var previews: some View {
        Group {
            Markdown.SnippetBlockView(unit: unit)
                .padding()
                .previewLayout(.sizeThatFits)
                .background(Color.mainBackground)
                .environment(\.colorScheme, .light)
            
            Markdown.SnippetBlockView(unit: unit)
                .padding()
                .previewLayout(.sizeThatFits)
                .background(Color.mainBackground)
                .environment(\.colorScheme, .dark)
        }
    }
}
#endif

// MARK: - Extensions

fileprivate extension Color {
    static let border = Color("snippetBlockBorder")
    static let background = Color("codeBlockBackground")
    static let foreground = Color("codeBlockForeground")
    #if DEBUG
    static let mainBackground = Color("mainBackground")
    #endif
}
