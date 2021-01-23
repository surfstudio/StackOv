//
//  Unit.swift
//  StackOv (Markdown module)
//
//  Created by Erik Basargin
//  Copyright © 2021 Erik Basargin. All rights reserved.
//

import Foundation
import Down
import HTMLEntities

public extension Markdown {
    
    final class Unit: Identifiable {
        
        // MARK: - Public properties
        
        public let id: Int
        public let type: UnitType
        public let data: UnitData?
        public private(set) var children: [Unit] = []
        public private(set) weak var parent: Unit?
        
        public var listType: List.ListType {
            guard case let .list(type, _) = type else {
                return .bullet
            }
            return type
        }
        
        public var listMark: String {
            if case let .ordered(start) = listType {
                return "\(id + start)."
            }
            return "•"
        }
        
        // MARK: - Initialization and deinitialization
        
        public convenience init?(_ value: String) {
            guard let rootNode = try? Down(markdownString: value).toAST().wrap() as? Document else {
                return nil
            }
            self.init(id: .zero, parent: nil, node: rootNode)
        }
        
        init(id: Int, type: UnitType, parent: Unit?, children: [Unit] = []) {
            self.id = id
            self.type = type
            self.parent = parent
            self.data = nil
            self.children = children
        }
        
        init?(id: Int, parent: Unit?, node: Node) {
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
