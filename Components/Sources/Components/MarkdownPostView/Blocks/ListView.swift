//
//  ListView.swift
//  StackOv (Components module)
//
//  Created by Erik Basargin
//  Copyright © 2021 Erik Basargin. All rights reserved.
//

import SwiftUI
import Markdown

extension Markdown {
    
    struct ListView: MarkdownUnitView {
        
        // MARK: - Properties
        
        let unit: Unit
        
        // MARK: - View
        
        var body: some View {
            VStack(alignment: .leading, spacing: .zero) {
                ForEach(unit.children) { child in
                    HStack(alignment: .top, spacing: 6) {
                        Text(child.listMark)
                            .padding(.top, 6)
                            .fixedSize(horizontal: true, vertical: true)
                        GlobalBlockView(unit: child)
                    }
                }
            }
        }
    }
    
}
