//
//  RepetitiveView.swift
//  StackOv (Components module)
//
//  Created by Erik Basargin
//  Copyright © 2021 Erik Basargin. All rights reserved.
//

import SwiftUI
import HTMLMarkdown

extension MarkdownPostView {
    
    struct RepetitiveView: StyleableUnitView {
        
        // MARK: - Properties
        
        let style: Style
        let unit: HTMLMarkdown.Unit
        let isLazy: Bool
        
        init(style: Style, unit: HTMLMarkdown.Unit, isLazy: Bool = false) {
            self.style = style
            self.unit = unit
            self.isLazy = isLazy
        }
        
        // MARK: - View
        
        var body: some View {
            if isLazy {
                LazyVStack(alignment: unit.horizontalAlignment, spacing: 10) {
                    content
                }
            } else {
                VStack(alignment: unit.horizontalAlignment, spacing: 10) {
                    content
                }
            }
        }
        
        var content: some View {
            ForEach(unit.children) { child in
                switch child.type {
                case .document, .tableItem, .listItem:
                    fatalError("RepetitiveView has got unsupported unit \(unit)")
                case .paragraph, .section:
                    RepetitiveView(style: style, unit: child)
                case .blockQuote:
                    BlockQuoteView(style: style, unit: child)
                case .list:
                    ListView(style: style, unit: child)
                case .codeBlock:
                    CodeBlockView(style: style, unit: child)
                case .table:
                    TableView(style: style, unit: child)
                case .text:
                    TextView(style: style, unit: child)
                case .image:
                    ImageView(style: style, unit: child)
                case .thematicBreak:
                    Divider()
                }
            }
        }
    }
    
}

// MARK: - Extensions

extension HTMLMarkdown.Unit {
    
    var horizontalAlignment: HorizontalAlignment {
        if case let .tableItem(_, alignment) = type {
            return alignment
        }
        return .leading
    }
}
