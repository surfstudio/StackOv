//
//  UnitData.swift
//  StackOv (Markdown module)
//
//  Created by Erik Basargin
//  Copyright © 2021 Erik Basargin. All rights reserved.
//

import Foundation
import Down

public extension Markdown {
    
    enum UnitData {
        case code(codeType: String?, code: String)
        case text(data: [TextEndpoint])
        
        init?(node: Node) {
            switch node.unitType {
            case .paragraph:
                self = .text(data: node.children.flatMap { Self.configureTextEndpoints(at: $0) })
            case .header:
                self = .text(data: node.children.compactMap {
                    TextEndpoint(inlineNode: $0, textAttributes: [.header])
                })
            default:
                return nil
            }
        }
        
        // MARK: - Static methods
        
        static func configureTextEndpoints(at node: Node) -> [TextEndpoint] {
            switch node.unitType {
            case .emphasis:
                return node.children.compactMap { TextEndpoint(inlineNode: $0, textAttributes: [.emphasis]) }
            case .strong:
                return node.children.compactMap { TextEndpoint(inlineNode: $0, textAttributes: [.strong]) }
            default:
                guard let textEndpoint = TextEndpoint(inlineNode: node) else { return [] }
                return [textEndpoint]
            }
        }
    }
}
