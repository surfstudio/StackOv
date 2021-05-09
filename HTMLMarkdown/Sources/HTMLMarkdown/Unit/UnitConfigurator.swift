//
//  UnitConfigurator.swift
//  StackOv (HTMLMarkdown module)
//
//  Created by Erik Basargin
//  Copyright © 2021 Erik Basargin. All rights reserved.
//

import Foundation
import class SwiftSoup.Element
import class SwiftSoup.TextNode
import class SwiftSoup.Entities
import struct SwiftUI.HorizontalAlignment
import struct CoreGraphics.CGFloat

final class UnitConfigurator {
    
    // MARK: - Neasted types
    
    enum LogicError: Error {
        case starterElementIsNotBlock(Element)
    }
    
    fileprivate enum Constants {
        static let emptyTags = Set(["img", "hr", "pre"])
        static let blockTags = Set(["body", "p", "div", "dl", "ul",
                                    "ol", "blockquote", "th", "td", "table",
                                    "dt", "dd", "li"])
        static let unitTypeTags = Set(blockTags.map { $0 } + emptyTags.map { $0 })
        static let splitterTags = Set(unitTypeTags.map { $0 } + ["h1", "h2", "h3"])
    }
    
    typealias Layer = [HTMLMarkdown.Unit]
    typealias Styles = Set<HTMLMarkdown.UnitStyle>
    
    // MARK: - Properties
    
    let rootElement: Element
    private(set) var currentText: [HTMLMarkdown.TextUnit] = []
    
    // MARK: - Initialization and deinitialization
    
    private init(root: Element) {
        self.rootElement = root
    }
    
    // MARK: - Static methods
    
    static func make(withBlock element: Element) throws -> HTMLMarkdown.Unit {
        guard element.isBlock() else {
            throw LogicError.starterElementIsNotBlock(element)
        }
        var mainLayer: Layer = []
        UnitConfigurator(root: element).configure(&mainLayer, withElement: element, withStyles: [])
        return HTMLMarkdown.Unit(type: .document, rootElement: element, htmlElement: element, children: mainLayer)
    }
    
    // MARK: - Methods
    
    func configure(_ layer: inout Layer, withElement element: Element, withStyles styles: Styles) {
        for node in element.getChildNodes() {
            switch node {
            case let child as TextNode:
                process(textNode: child, withStyles: styles)
            case let child as Element where child.tagNameNormal() == "br":
                currentText.append(HTMLMarkdown.TextUnit(type: .newLine))
            case let child as Element:
                process(element: child, inLayer: &layer, withStyles: styles)
            default:
                break
            }
        }
        
        if element.isNeededToFinaliseText {
            finaliseText(inLayer: &layer, forElement: element)
        }
    }
    
    func process(element: Element, inLayer layer: inout Layer, withStyles styles: Styles) {
        let tagName = element.tagNameNormal()
        let newStyles = styles + element.unitStyle
        
        if Constants.unitTypeTags.contains(tagName) {
            topUp(&layer, withElement: element, withStyles: newStyles)
        } else {
            configure(&layer, withElement: element, withStyles: newStyles)
        }
    }
    
    func topUp(_ layer: inout Layer, withElement element: Element, withStyles styles: Styles) {
        assert(Constants.unitTypeTags.contains(element.tagNameNormal()))
        
        var nextLayer: Layer = []
        
        if Constants.blockTags.contains(element.tagNameNormal()) {
            element.simplifyTableTagIfNeeded()
            configure(&nextLayer, withElement: element, withStyles: styles)
        }
        
        finaliseText(inLayer: &layer, forElement: element)
        if let type = element.unitType {
            layer.append(
                HTMLMarkdown.Unit(type: type, rootElement: rootElement, htmlElement: element, children: nextLayer)
            )
        }
    }
    
    func process(textNode: TextNode, withStyles styles: Styles) {
        let text = textNode.text()
        if !text.trimmingCharacters(in: .whitespaces).isEmpty {
            currentText.append(
                HTMLMarkdown.TextUnit(type: .text(text, styles: styles))
            )
        }
    }
    
    func finaliseText(inLayer layer: inout Layer, forElement element: Element) {
        guard !currentText.isEmpty else { return }
        layer.append(
            HTMLMarkdown.Unit(type: .text(children: currentText), rootElement: rootElement, htmlElement: element, children: [])
        )
        currentText = []
    }
}

// MARK: - Extensions

fileprivate extension Set {
    
    static func +(left: Self, right: Element?) -> Self {
        guard let right = right else { return left }
        var new = left
        new.insert(right)
        return new
    }
}

fileprivate extension String {
    
    func firstMatch(regex: String, group: Int) throws -> String? {
        let regex = try NSRegularExpression(pattern: regex)
        if let match = regex.firstMatch(in: self, options: [], range: NSRange(0..<self.count)),
           let range = Range(match.range(at: group), in: self) {
            return String(self[range])
        }
        return nil
    }
    
    func htmlUnescape() -> String {
        (try? Entities.unescape(self)) ?? self
    }
}

fileprivate extension Element {
    
    func simplifyTableTagIfNeeded() {
        guard tagNameNormal() == "table" else { return }
        _ = try? select("thead").unwrap()
        _ = try? select("tbody").unwrap()
        _ = try? select("tr").unwrap()
    }
    
    var isNeededToFinaliseText: Bool {
        UnitConfigurator.Constants.splitterTags.contains(tagNameNormal())
    }
    
    var unitStyle: HTMLMarkdown.UnitStyle? {
        switch tagNameNormal() {
        case "a":
            if let href = try? attr("href"), let url = URL(string: href) {
                return .link(url: url)
            } else {
                return nil
            }
        case "b", "strong":
            return .bold
        case "code", "kbd":
            return .code
        case "del", "s", "strike":
            return .strikethrough
        case "i", "em":
            return .italic
        case "h1":
            return .header(level: 1)
        case "h2":
            return .header(level: 2)
        case "h3":
            return .header(level: 3)
        case "sub":
            return .subscriptText
        case "sup":
            return .superscriptText
        default:
            return nil
        }
    }
    
    var unitType: HTMLMarkdown.UnitType? {
        switch tagNameNormal() {
        case "p":
            return .paragraph
        case "div":
            return .section
        case "dl", "ul":
            return .list(style: .unordered)
        case "ol":
            let start: Int = Int((try? attr("start")) ?? "") ?? 1
            return .list(style: .ordered(start: start))
        case "dt":
            return .listItem(style: .descriptionTitle)
        case "dd":
            return .listItem(style: .descriptionDetails)
        case "li":
            return .listItem(style: .item)
        case "blockquote":
            return .blockQuote
        case "table":
            let headersNumber = (try? select("th").count) ?? .zero
            return headersNumber > 0 ? .table(columns: headersNumber) : nil
        case "th", "td":
            let isHeader = tagNameNormal() == "th"
            let style: HorizontalAlignment
            switch try? attr("style").firstMatch(regex: #"text-align:(\w*)"#, group: 1) {
            case "right":
                style = .trailing
            case "center":
                style = .center
            default:
                style = .leading
            }
            return .tableItem(isHeader: isHeader, alignment: style)
        case "img":
            if let url = URL(string: (try? attr("src")) ?? "") {
                let width = Double((try? attr("width")) ?? "")
                let height = Double((try? attr("height")) ?? "")
                let cgWidth = width == nil ? nil : CGFloat(width!)
                let cgHeight = height == nil ? nil : CGFloat(height!)
                return .image(url: url, description: try? attr("alt"), width: cgWidth, height: cgHeight)
            } else {
                return nil
            }
        case "hr":
            return .thematicBreak
        case "pre":
            if let codeNode = children().first(), codeNode.tagNameNormal() == "code" {
                let className = (try? className()) ?? ""
                let isSnippet = className.hasPrefix("snippet-code-")
                let lang = try? className.firstMatch(regex: #"lang\-(\w*)"#, group: 1)
                if let code = try? codeNode.text() {
                    return .codeBlock(code: code, lang: lang, isSnippet: isSnippet)
                } else {
                    return nil
                }
            } else if let text = try? html() {
                return .codeBlock(code: text.htmlUnescape(), lang: nil, isSnippet: false)
            } else {
                return nil
            }
        default:
            return nil
        }
    }
}
