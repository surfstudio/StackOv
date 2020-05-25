//
//  CodeBlockView.swift
//  StackoverflowIOS
//
//  Created by Erik Basargin on 17/05/2020.
//  Copyright © 2020 Ephedra Software. All rights reserved.
//

import SwiftUI

extension Markdown {
    
    struct CodeBlockView: MarkdownUnitView {
        let unit: Unit
        
        var body: some View {
            guard case let .codeBlock(_, code) = unit.type else {
                return AnyView(EmptyView())
            }
            return AnyView(content(code))
        }
        
        private func content(_ code: String) -> some View {
            ScrollView(.horizontal, showsIndicators: true) {
                VStack(alignment: .center, spacing: .zero) {
                    Text(code)
                        .font(.custom("Menlo-Regular", size: 13))
                        .foregroundColor(.foreground)
                        .fixedSize(horizontal: false, vertical: true)
                }
            }
            .padding([.leading, .top, .trailing], 12)
            .background(Color.background)
            .cornerRadius(6)
            .padding(.bottom, 3)
        }
    }
    
}

// MARK: - Previews

#if DEBUG
struct CodeBlockView_Previews: PreviewProvider {
    static let unit = Markdown.Unit("""
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
    """)!.children.first!
    static var previews: some View {
        Group {
            Markdown.CodeBlockView(unit: unit)
                .padding()
                .previewLayout(.sizeThatFits)
                .background(Color.mainBackground)
                .environment(\.colorScheme, .light)
            
            Markdown.CodeBlockView(unit: unit)
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
    static let background = Color("codeBlockBackground")
    static let foreground = Color("codeBlockForeground")
    #if DEBUG
    static let mainBackground = Color("mainBackground")
    #endif
}
