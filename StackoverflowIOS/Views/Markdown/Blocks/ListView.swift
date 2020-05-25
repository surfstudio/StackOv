//
//  ListView.swift
//  StackoverflowIOS
//
//  Created by Erik Basargin on 17/05/2020.
//  Copyright © 2020 Ephedra Software. All rights reserved.
//

import SwiftUI

extension Markdown {
    
    struct ListView: MarkdownUnitView {
        let unit: Unit
        
        var body: some View {
            VStack(alignment: .leading, spacing: .zero) {
                ForEach(unit.children, id: \.id) { child in
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
