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
        
        // MARK: - Neasted types
        
        enum SnippetStep: Error {
            case beginSnippet
            case snippetCodeType
            case snippetIsEmpty
            case isSnippet
            case isSnippetBody
        }
        
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

            let snippet = SnippetContainer()
            switch type {
            case .document, .blockQuote, .list, .item:
                self.data = nil
                self.children = configureChildren(at: node, snippet: snippet)
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
                    self.data = .text(htmlString) //NSAttributedString.from(htmlString: htmlString))
                } else {
                    self.data = nil
                }
                self.children = []
            }
        }

        // MARK: - Internal methods

        func configureChildren(at node: Node, snippet: SnippetContainer) -> [Unit] {
            node.children.enumerated().compactMap { children in
                guard let unit = Unit(id: children.offset, parent: self, node: children.element) else {
                    return nil
                }
                switch unit.type {
                case let .htmlBlock(htmlText):
                    return try? configureHTMLBlock(id: id, htmlContent: htmlText, unit: unit, snippet: snippet)
                case let .codeBlock(_, code):
                    return try? configureCodeBlock(unit: unit, snippet: snippet, code: code)
                default:
                    return snippet.snippetBlock ? nil : unit
                }
            }
        }

        func configureHTMLBlock(id: Int, htmlContent: String, unit: Unit, snippet: SnippetContainer) throws -> Unit {
            let htmlContent = htmlContent.lowercased()
            switch htmlContent.contains("begin snippet") {
            case true:
                snippet.snippetBlock = true
                throw SnippetStep.beginSnippet
            case false where htmlContent.contains("language"):
                snippet.snippetCodeType = try htmlContent.firstMatch(regex: #"lang\-(\w*)"#, group: 1)
                throw SnippetStep.snippetCodeType
            case false where htmlContent.contains("end snippet"):
                defer {
                    snippet.snippetBlock = false
                    snippet.snippets = []
                }
                if snippet.snippets.isEmpty {
                    throw SnippetStep.snippetIsEmpty
                }
                return Unit(id: id, type: .snippetBlock(snippet.snippets), parent: self, children: [])
            case false:
                if htmlContent.starts(with: "<pre>"), !snippet.snippetBlock {
                    let code = htmlContent.htmlUnescape()
                        .replacingOccurrences(of: "<pre>", with: "")
                        .replacingOccurrences(of: "</pre>", with: "")
                    return Unit(id: id, type: .codeBlock(codeType: nil, code: code), parent: self, children: [])
                } else {
                    if snippet.snippetBlock {
                        throw SnippetStep.isSnippet
                    }
                    return unit
                }
            }
        }

        func configureCodeBlock(unit: Unit, snippet: SnippetContainer, code: String) throws -> Unit {
            if snippet.snippetBlock {
                snippet.snippets.append(Unit(id: snippet.snippets.count, type: .codeBlock(codeType: snippet.snippetCodeType, code: code), parent: self, children: []))
                snippet.snippetCodeType = nil
                throw SnippetStep.isSnippetBody
            } else {
                return unit
            }
        }
    }
}

// MARK: - Extensions

fileprivate extension Markdown.Unit.SnippetStep {
    
    var localizedDescription: String {
        switch self {
        case .beginSnippet: return "Begin of the snippet"
        case .snippetCodeType: return "Snippet code's type"
        case .snippetIsEmpty: return "Snippet is empty"
        case .isSnippet: return "Is the snippet"
        case .isSnippetBody: return "Is the snipped body"
        }
    }
}
