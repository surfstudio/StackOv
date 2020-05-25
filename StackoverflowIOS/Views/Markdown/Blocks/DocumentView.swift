//
//  DocumentView.swift
//  StackoverflowIOS
//
//  Created by Erik Basargin on 17/05/2020.
//  Copyright © 2020 Ephedra Software. All rights reserved.
//

import SwiftUI

extension Markdown {
    
    struct DocumentView: MarkdownUnitView {
        let unit: Unit
        
        var body: some View {
            GlobalBlockView(unit: unit)
        }
    }
    
}
