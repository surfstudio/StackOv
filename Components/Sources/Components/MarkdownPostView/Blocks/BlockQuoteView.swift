//
//  BlockQuoteView.swift
//  StackOv (Components module)
//
//  Created by Erik Basargin
//  Copyright © 2021 Erik Basargin. All rights reserved.
//

import SwiftUI
import HTMLMarkdown
import Palette

extension MarkdownPostView {
    
    struct BlockQuoteView: StyleableUnitView {
        
        // MARK: - Properties
        
        let style: Style
        let unit: HTMLMarkdown.Unit
        
        // MARK: - View
        
        var body: some View {
            if unit.type == .blockQuote {
                HStack(alignment: .top, spacing: 6) {
                    Color.background.frame(width: 4)
                    RepetitiveView(style: style, unit: unit)
                }
                .fixedSize(horizontal: false, vertical: true)
            } else {
                fatalError("BlockQuoteView has got unsupported unit \(unit)")
            }
        }
    }
}

// MARK: - Colors

fileprivate extension Color {
    
    static let background = Palette.dullGray
}
