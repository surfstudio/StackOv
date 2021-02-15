//
//  UnitType.swift
//  StackOv (Markdown module)
//
//  Created by Erik Basargin
//  Copyright © 2021 Erik Basargin. All rights reserved.
//

import Foundation
import Down
import libcmark

public extension Markdown {
    
    enum UnitType: Hashable {
        
        // MARK: - Blocks
        
        /// CMARK_NODE_DOCUMENT
        case document
        /// CMARK_NODE_BLOCK_QUOTE
        case blockQuote
        /// CMARK_NODE_LIST
        case list(type: List.ListType, numberOfItems: Int)
        /// CMARK_NODE_ITEM
        case item
        /// CMARK_NODE_CODE_BLOCK
        case codeBlock(codeType: String?, code: String)
        /// CMARK_NODE_HTML_BLOCK
        case htmlBlock(htmlText: String)
        /// CMARK_NODE_CUSTOM_BLOCK
        case customBlock(text: String)
        /// CMARK_NODE_PARAGRAPH
        case paragraph
        /// CMARK_NODE_HEADING
        case header(level: Int)
        /// CMARK_NODE_THEMATIC_BREAK
        case thematicBreak
        
        // MARK: - Inline blocks
        
        /// CMARK_NODE_TEXT
        case text(String)
        /// CMARK_NODE_SOFTBREAK
        case softBreak
        /// CMARK_NODE_LINEBREAK
        case lineBreak
        /// CMARK_NODE_CODE
        case code(String)
        /// CMARK_NODE_HTML_INLINE
        case htmlInline(String)
        /// CMARK_NODE_CUSTOM_INLINE
        case customInline(String)
        /// CMARK_NODE_EMPH
        case emphasis
        /// CMARK_NODE_STRONG
        case strong
        /// CMARK_NODE_LINK
        case link(title: String?, url: URL)
        /// CMARK_NODE_IMAGE
        case image(title: String?, url: URL)
        
        // MARK: - Custom blocks
        
        case snippetBlock(_ units: [Unit])
    }
}

public extension Markdown.UnitType {
    
    static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs.hashValue == rhs.hashValue
    }

    func hash(into hasher: inout Hasher) {
        switch self {
        case .document:
            hasher.combine(CMARK_NODE_DOCUMENT.rawValue)
        case .blockQuote:
            hasher.combine(CMARK_NODE_BLOCK_QUOTE.rawValue)
        case .list:
            hasher.combine(CMARK_NODE_LIST.rawValue)
        case .item:
            hasher.combine(CMARK_NODE_ITEM.rawValue)
        case .codeBlock:
            hasher.combine(CMARK_NODE_CODE_BLOCK.rawValue)
        case .htmlBlock:
            hasher.combine(CMARK_NODE_HTML_BLOCK.rawValue)
        case .customBlock:
            hasher.combine(CMARK_NODE_CUSTOM_BLOCK.rawValue)
        case .paragraph:
            hasher.combine(CMARK_NODE_PARAGRAPH.rawValue)
        case .header:
            hasher.combine(CMARK_NODE_HEADING.rawValue)
        case .thematicBreak:
            hasher.combine(CMARK_NODE_THEMATIC_BREAK.rawValue)
        case .text:
            hasher.combine(CMARK_NODE_TEXT.rawValue)
        case .softBreak:
            hasher.combine(CMARK_NODE_SOFTBREAK.rawValue)
        case .lineBreak:
            hasher.combine(CMARK_NODE_LINEBREAK.rawValue)
        case .code:
            hasher.combine(CMARK_NODE_CODE.rawValue)
        case .htmlInline:
            hasher.combine(CMARK_NODE_HTML_INLINE.rawValue)
        case .customInline:
            hasher.combine(CMARK_NODE_CUSTOM_INLINE.rawValue)
        case .emphasis:
            hasher.combine(CMARK_NODE_EMPH.rawValue)
        case .strong:
            hasher.combine(CMARK_NODE_STRONG.rawValue)
        case .link:
            hasher.combine(CMARK_NODE_LINK.rawValue)
        case .image:
            hasher.combine(CMARK_NODE_IMAGE.rawValue)
        case .snippetBlock:
            hasher.combine("snippetBlock")
        }
    }
}
