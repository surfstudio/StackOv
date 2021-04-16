//
//  TextView.swift
//  StackOv (Components module)
//
//  Created by Evgeny Novgorodov
//  Copyright © 2021 Erik Basargin. All rights reserved.
//

import SwiftUI
import Markdown

extension Markdown {
    
    struct TextView: MarkdownUnitView {
        
        // MARK: - Properties
        
        let unit: Unit
        
        // MARK: - View
        
        var body: some View {
            if let unitData = unit.data,
               case let .text(textEndpoints) = unitData {
                HStack {
                    ForEach(textEndpoints, id: \.self) { textEndpoint in
                        switch textEndpoint {
                        case let .text(value, attributes):
                            if attributes.isEmpty {
                                Text(value)
                            } else if attributes.contains(.header) {
                                Text(value)
                                    .font(.title)
                            } else if attributes.contains(.strong) {
                                Text(value)
                                    .bold()
                            } else {
                                Text(value)
                                    .italic()
                            }
                        case let .code(value):
                            Text(value)
                                .background(Color.gray)
                        case let .link(title, url):
                            Link(title, destination: url)
                        default:
                            EmptyView()
                        }
                    }
                }
            } else {
                EmptyView()
            }
        }
    }
}
