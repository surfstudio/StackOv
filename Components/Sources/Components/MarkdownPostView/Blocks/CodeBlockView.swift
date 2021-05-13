//
//  CodeBlockView.swift
//  StackOv (Components module)
//
//  Created by Erik Basargin
//  Copyright © 2021 Erik Basargin. All rights reserved.
//

import SwiftUI
import HTMLMarkdown
import Palette
import Common
import Errors

extension MarkdownPostView {
    
    struct CodeBlockView: StyleableUnitView {
        
        // MARK: - Properties
        
        let style: Style
        let unit: HTMLMarkdown.Unit
        
        // MARK: - View
        
        var body: some View {
            if case let .codeBlock(code, _, isSnippet) = unit.type {
                content(code: code)
                    .modifier(CodeBlockStyle(isSnippet: isSnippet))
                    .contextMenu {
                        Button("Copy of the code") {
                            UIPasteboard.general.string = code
                        }
                        Button("Full copy") {
                            do {
                                UIPasteboard.general.string = try unit.rootElement.text()
                            } catch {
                                GlobalBanner.show(error: PasteboardError.unknown)
                            }
                        }
                    }
            } else {
                fatalError("CodeBlockView has got unsupported unit \(unit)")
            }
        }
        
        // MARK: - View methods
        
        func content(code: String) -> some View {
            ScrollView(.horizontal, showsIndicators: true) {
                VStack(alignment: .center, spacing: .zero) {
                    Text(code)
                        .font(.custom("Menlo-Regular",
                                      size: style == .post ? 15 : 13,
                                      relativeTo: style == .post ? .subheadline : .footnote))
                        .fontWeight(.regular)
                        .foregroundColor(.foreground)
                        .fixedSize(horizontal: false, vertical: true)
                }
            }
            .padding(12)
            .background(Color.background)
            .cornerRadius(6)
            .padding(.bottom, 3)
        }
    }
}

// MARK: - View modifiers

fileprivate struct CodeBlockStyle: ViewModifier {
    
    let isSnippet: Bool
    
    @ViewBuilder
    func body(content: Content) -> some View {
        if isSnippet {
            VStack(spacing: 13) {
                content
            }
            .padding(.all, 12)
            .border(Color.snippetBorder)
        } else {
            content
        }
    }
}

// MARK: - Colors

fileprivate extension Color {
    
    static let snippetBorder = Palette.main.opacity(0.12) | Color.white.opacity(0.08)
    static let background = Palette.lightGray | Color.white.opacity(0.04)
    static let foreground = Palette.black | Color.white
}
