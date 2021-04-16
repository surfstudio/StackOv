//
//  TextEndpoint.swift
//  StackOv (Markdown module)
//
//  Created by Evgeny Novgorodov
//  Copyright © 2021 Erik Basargin. All rights reserved.
//

import Foundation
import Down

public extension Markdown {
    
    enum TextEndpoint: Hashable {
        
        public enum TextEndpointAttribute {
            case header
            case strong
            case emphasis
        }
        
        case text(value: String, attributes: [TextEndpointAttribute])
        case softBreak
        case lineBreak
        case code(value: String)
        case htmlInline(value: String)
        case customInline(value: String)
        case link(title: String, url: URL)
        case image(title: String, url: URL)
        
        init?(inlineNode: Node, textAttributes: [TextEndpointAttribute] = []) {
            switch inlineNode.unitType {
            case let .text(value):
                self = .text(value: value, attributes: textAttributes)
            case .softBreak:
                self = .softBreak
            case .lineBreak:
                self = .lineBreak
            case let .code(value):
                self = .code(value: value)
            case let .htmlInline(value):
                self = .htmlInline(value: value)
            case let .customInline(value):
                self = .customInline(value: value)
            case .emphasis:
                let attributes = textAttributes + [.emphasis]
                guard let child = inlineNode.children.first,
                      let textEndpoint = TextEndpoint(inlineNode: child,
                                                      textAttributes: attributes) else {
                    return nil
                }
                self = textEndpoint
            case .strong:
                let attributes = textAttributes + [.strong]
                guard let child = inlineNode.children.first,
                      let textEndpoint = TextEndpoint(inlineNode: child,
                                                      textAttributes: attributes) else {
                    return nil
                }
                self = textEndpoint
            case let .link(title, url):
                if let child = inlineNode.children.first,
                   let textEndpoint = TextEndpoint(inlineNode: child),
                   case let .text(linkTitle, _) = textEndpoint {
                    self = .link(title: linkTitle, url: url)
                } else {
                    self = .link(title: title ?? "", url: url)
                }
            case let .image(title, url):
                if let child = inlineNode.children.first,
                   let textEndpoint = TextEndpoint(inlineNode: child),
                   case let .text(linkTitle, _) = textEndpoint {
                    self = .image(title: linkTitle, url: url)
                } else {
                    self = .image(title: title ?? "", url: url)
                }
            default:
                return nil
            }
        }
    }
}
