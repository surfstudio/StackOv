//
//  Markdown.swift
//  StackoverflowIOS
//
//  Created by Erik Basargin on 16/05/2020.
//  Copyright © 2020 Ephedra Software. All rights reserved.
//

import Foundation
import libcmark
import Down
import HTMLEntities

enum Markdown {

    enum UnitType {
        // MARK: - Block
        
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
        
        // MARK: - Custom block
        
        case snippetBlock(_ units: [Unit])
        
        // MARK: - Inline
        
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
    }
    
    enum UnitData {
        case code(codeType: String?, code: String)
        case text(NSAttributedString.LazyString)
    }
    
    final class Unit: Identifiable {
        let id: Int
        let type: UnitType
        let data: UnitData?
        private(set) var children: [Unit] = []
        private(set) weak var parent: Unit?
        
        var listType: List.ListType {
            guard case let .list(type, _) = type else {
                return .bullet
            }
            return type
        }
        
        var listMark: String {
            if case let .ordered(start) = listType {
                return "\(id + start)."
            }
            return "•"
        }
        
        convenience init?(_ value: String) {
            guard let rootNode = try? Down(markdownString: value).toAST().wrap() as? Document else {
                return nil
            }
            self.init(id: .zero, parent: nil, node: rootNode)
        }
        
        private init(id: Int, type: UnitType, parent: Unit?, children: [Unit] = []) {
            self.id = id
            self.type = type
            self.parent = parent
            self.data = nil
            self.children = children
        }
        
        private init?(id: Int, parent: Unit?, node: Node) {
            guard let type = node.unitType else {
                return nil
            }
            self.id = id
            self.type = type
            self.parent = parent
            
            var snippetBlock = false
            var snippetCodeType: String?
            var snippet: [Unit] = []
            switch type {
            case .document, .blockQuote, .list, .item:
                self.data = nil
                self.children = node.children.enumerated().compactMap { [weak self] child in
                    guard let unit = Unit(id: child.offset, parent: self, node: child.element) else {
                        return nil
                    }
                    switch unit.type {
                    case let .htmlBlock(htmlText):
                        let htmlContent = htmlText.lowercased()
                        if htmlContent.contains("begin snippet") {
                            snippetBlock = true
                            return nil
                        } else if snippetBlock, htmlContent.contains("language") {
                            snippetCodeType = try? htmlText.firstMatch(regex: #"lang\-(\w*)"#, group: 1)
                            return nil
                        } else if htmlContent.contains("end snippet") {
                            defer {
                                snippetBlock = false
                                snippet = []
                            }
                            return snippet.isEmpty
                                ? nil
                                : Unit(id: child.offset, type: .snippetBlock(snippet), parent: self, children: [])
                        } else if htmlContent.starts(with: "<pre>"), !snippetBlock {
                            let code = htmlText.htmlUnescape()
                                .replacingOccurrences(of: "<pre>", with: "")
                                .replacingOccurrences(of: "</pre>", with: "")
                            return Unit(id: child.offset, type: .codeBlock(codeType: nil, code: code), parent: self, children: [])
                        } else {
                            return snippetBlock ? nil : unit
                        }
                    case let .codeBlock(_, code):
                        if snippetBlock {
                            snippet.append(Unit(id: snippet.count, type: .codeBlock(codeType: snippetCodeType, code: code), parent: self, children: []))
                            snippetCodeType = nil
                            return nil
                        } else {
                            return unit
                        }
                    default:
                        return snippetBlock ? nil : unit
                    }
                }
            case let .codeBlock(codeType, code):
                self.data = .code(codeType: codeType, code: code)
                self.children = []
            case .thematicBreak:
                self.data = nil
                self.children = []
            default:
                if var htmlString = try? DownCommonMarkRenderer.astToCommonMark(node.cmarkNode).toHTML() {
                    if type == .paragraph {
                        htmlString = htmlString
                            .replacingOccurrences(of: "<p>", with: "")
                            .replacingOccurrences(of: "</p>", with: "")
                    }
                    self.data = .text(NSAttributedString.from(htmlString: htmlString))
                } else {
                    self.data = nil
                }
                self.children = []
            }
        }
    }
    
}

extension Markdown.UnitType: Hashable {
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
        case .snippetBlock:
            hasher.combine("snippetBlock")
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
        }
    }
}

fileprivate extension Node {
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
