//
//  GlobalBlockView.swift
//  StackOv (Components module)
//
//  Created by Erik Basargin
//  Copyright © 2021 Erik Basargin. All rights reserved.
//

import SwiftUI
import Markdown

extension Markdown {
    
    struct GlobalBlockView: MarkdownUnitView {
        
        // MARK: - Properties
        
        let unit: Unit
        
        // MARK: - View
        
        var body: some View {
            VStack(alignment: .leading, spacing: .zero) {
                ForEach(unit.children, id: \.id) { child in
                    switch child.type {
                    case .blockQuote:
                        BlockQuoteView(unit: child)
                    case .list:
                        ListView(unit: child)
                    case .codeBlock:
                        CodeBlockView(unit: child)
                    case .snippetBlock:
                        SnippetBlockView(unit: child)
                    case .thematicBreak:
                        Divider()
                            .padding([.top, .bottom], 4)
                    default:
                        if case let .text(lazyHtmlText) = child.data {
//                            MarkdownTextView(lazyHtmlText: lazyHtmlText)
                            Text(lazyHtmlText)
                        } else {
                            fatalError("Unsupported type: \(child.type)")
                        }
                    }
                }
            }
        }
    }
    
}
