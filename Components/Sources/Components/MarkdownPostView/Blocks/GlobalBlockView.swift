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
        let unit: Unit
        
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
                        if case let .text(lazyText) = child.data {
                            MarkdownTextView(attributedText: lazyText)
                        } else {
                            fatalError("Unsupported type: \(child.type)")
                        }
                    }
                }
            }
        }
    }
    
}
