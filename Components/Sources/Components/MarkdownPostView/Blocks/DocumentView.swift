//
//  DocumentView.swift
//  StackOv (Components module)
//
//  Created by Erik Basargin
//  Copyright © 2021 Erik Basargin. All rights reserved.
//

import SwiftUI
import HTMLMarkdown

extension MarkdownPostView {
    
    struct DocumentView: StyleableUnitView {
        
        // MARK: - Properties
        
        let style: Style
        let unit: HTMLMarkdown.Unit
        
        // MARK: - View
        
        var body: some View {
            if unit.type == .document {
                RepetitiveView(style: style, unit: unit)
            } else {
                fatalError("DocumentView has got unsupported unit \(unit)")
            }
        }
    }
}
