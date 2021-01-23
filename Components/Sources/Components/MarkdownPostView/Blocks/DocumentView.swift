//
//  DocumentView.swift
//  StackOv (Components module)
//
//  Created by Erik Basargin
//  Copyright © 2021 Erik Basargin. All rights reserved.
//

import SwiftUI
import Markdown

extension Markdown {
    
    struct DocumentView: MarkdownUnitView {
        let unit: Unit
        
        var body: some View {
            GlobalBlockView(unit: unit)
        }
    }
    
}
