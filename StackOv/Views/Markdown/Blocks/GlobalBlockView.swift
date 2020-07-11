//
//  GlobalBlockView.swift
//  StackOv
//
//  Created by Erik Basargin on 17/05/2020.
//  Copyright © 2020 Ephedra Software. All rights reserved.
//

import SwiftUI

extension Markdown {
    
    struct GlobalBlockView: MarkdownUnitView {
        let unit: Unit
        
        var body: some View {
            VStack(alignment: .leading, spacing: .zero) {
                ForEach(unit.children, id: \.id) { child in
                    Group { () -> AnyView in
                        switch child.type {
                        case .blockQuote:
                            return AnyView(BlockQuoteView(unit: child))
                        case .list:
                            return AnyView(ListView(unit: child))
                        case .codeBlock:
                            return AnyView(CodeBlockView(unit: child))
                        case .snippetBlock:
                            return AnyView(SnippetBlockView(unit: child))
                        case .thematicBreak:
                            return AnyView(Divider().padding([.top, .bottom], 4))
                        default:
                            guard case let .text(lazyText) = child.data else {
                                fatalError("Unsupported type: \(child.type)")
                            }
                            return AnyView(MarkdownTextView(attributedText: lazyText))
                        }
                    }
                }
            }
        }
    }
    
}
