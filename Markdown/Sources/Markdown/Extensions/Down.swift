//
//  Down.swift
//  StackOv (Markdown module)
//
//  Created by Erik Basargin
//  Copyright © 2021 Erik Basargin. All rights reserved.
//

import Foundation
import Down
import libcmark

extension Node {
    
    var unitType: Markdown.UnitType? {
        switch self.cmarkNode.type {
        case CMARK_NODE_DOCUMENT:
            return .document
        case CMARK_NODE_BLOCK_QUOTE:
            return .blockQuote
        case CMARK_NODE_LIST:
            guard let node = self as? List else { return nil }
            return .list(type: node.listType, numberOfItems: node.numberOfItems)
        case CMARK_NODE_ITEM:
            return .item
        case CMARK_NODE_CODE_BLOCK:
            guard let node = self as? CodeBlock, let code = node.literal else { return nil }
            return .codeBlock(codeType: node.fenceInfo, code: code)
        case CMARK_NODE_HTML_BLOCK:
            guard let node = self as? HtmlBlock, let text = node.literal else { return nil }
            return .htmlBlock(htmlText: text)
        case CMARK_NODE_CUSTOM_BLOCK:
            guard let node = self as? CustomBlock, let text = node.literal else { return nil }
            return .customBlock(text: text)
        case CMARK_NODE_PARAGRAPH:
            return .paragraph
        case CMARK_NODE_HEADING:
            guard let node = self as? Heading else { return nil }
            return .header(level: node.headingLevel)
        case CMARK_NODE_THEMATIC_BREAK:
            return .thematicBreak
        case CMARK_NODE_TEXT:
            guard let node = self as? Text, let text = node.literal else { return nil }
            return .text(text)
        case CMARK_NODE_SOFTBREAK:
            return .softBreak
        case CMARK_NODE_LINEBREAK:
            return .lineBreak
        case CMARK_NODE_CODE:
            guard let node = self as? Code, let text = node.literal else { return nil }
            return .code(text)
        case CMARK_NODE_HTML_INLINE:
            guard let node = self as? HtmlInline, let text = node.literal else { return nil }
            return .htmlInline(text)
        case CMARK_NODE_CUSTOM_INLINE:
            guard let node = self as? CustomInline, let text = node.literal else { return nil }
            return .customInline(text)
        case CMARK_NODE_EMPH:
            return .emphasis
        case CMARK_NODE_STRONG:
            return .strong
        case CMARK_NODE_LINK:
            guard let node = self as? Link, let url = URL(string: node.url ?? "") else { return nil }
            return .link(title: node.title, url: url)
        case CMARK_NODE_IMAGE:
            guard let node = self as? Image, let url = URL(string: node.url ?? "") else { return nil }
            return .image(title: node.title, url: url)
        default:
            return nil
        }
    }
}
