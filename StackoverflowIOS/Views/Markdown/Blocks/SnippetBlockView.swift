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
            guard case let .snippetBlock(units) = unit.type else {
                return AnyView(EmptyView())
            }
            return AnyView(content(units))
        }
        
        private func content(_ units: [Unit]) -> some View {
            VStack(spacing: 13) {
                ForEach(units) { unit in
                    CodeBlockView(unit: unit)
                }
            }
            .padding(.all, 12)
            .border(Color.border)
            .padding(.bottom, 3)
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
    #if DEBUG
    static let mainBackground = Color("mainBackground")
    #endif
}
