//
//  Units.swift
//  StackOv (HTMLMarkdown module)
//
//  Created by Erik Basargin
//  Copyright © 2021 Erik Basargin. All rights reserved.
//

import Foundation
import SwiftSoup
import struct SwiftUI.HorizontalAlignment
import struct CoreGraphics.CGFloat

public extension HTMLMarkdown {
    
    // MARK: - Styles
    
    enum ListStyle {
        case ordered(start: Int)
        case unordered
    }
    
    enum ListItemStyle {
        case descriptionTitle
        case descriptionDetails
        case item
    }
    
    enum UnitStyle: Hashable {
        case link(url: URL)
        case bold
        case code
        case strikethrough
        case italic
        case header(level: Int)
        case superscriptText
        case subscriptText
    }
    
    // MARK: - Types
    
    enum TextType: Hashable {
        case text(String, styles: Set<UnitStyle>)
        /// Unit represents the `<br>` tag
        case newLine
    }
    
    enum UnitType: Hashable {
        /// Unit represents the `<body>` tag
        case document
        /// Unit represents the `<p>` tag
        case paragraph
        /// Unit represents the `<div>` tag
        case section
        /// Unit represents the `<blockquote>` tag
        case blockQuote
        /// Unit represents `<dl>/<ol>/<ul>` tags
        case list(style: ListStyle)
        /// Unit represents `<dt>/<dd>/<li>` tags
        case listItem(style: ListItemStyle) 
        /// Unit represents the group of tags `<pre class="{some class}"><code>...`
        /// For example,
        /// `<pre class="lang-cpp prettyprint-override"><code>`
        /// `<pre class="snippet-code-js lang-js prettyprint-override"><code>`
        /// `<pre class="snippet-code-css lang-css prettyprint-override"><code>`
        case codeBlock(code: String, lang: String?, isSnippet: Bool)
        /// Unit represents the `<table>` tag
        case table(columns: Int)
        /// Unit represents `<th>/<td>` tags
        case tableItem(isHeader: Bool, alignment: HorizontalAlignment)
        /// Unit represents a text part between any two units
        case text(children: [TextUnit])
        /// Unit represents the `<img>` tag
        case image(url: URL, description: String?, width: CGFloat?, height: CGFloat?)
        /// Unit represents the `<hr>` tag
        case thematicBreak
    }
    
    // MARK: - Text unit
    
    struct TextUnit: Identifiable {
        public let id: UUID = UUID()
        public let type: TextType
    }
    
    // MARK: - Unit
    
    struct Unit: Identifiable {
        public let id: UUID = UUID()
        public let type: UnitType
        public let rootElement: Element
        public let htmlElement: Element
        public let children: [Unit]
    }
}

// MARK: - Unit Errors

public extension HTMLMarkdown.Unit {
    
    enum PreparationDataError: Error {
        case bodyIsNill(Element)
    }
}

// MARK: - Extensions

public extension HTMLMarkdown.Unit {
    
    static func make(with htmlText: String) throws -> Self {
        let unescapeText = try Entities.unescape(htmlText)
        let document = try SwiftSoup.parse(unescapeText)
        if let body = document.body() {
            return try UnitConfigurator.make(withBlock: body)
        } else {
            throw PreparationDataError.bodyIsNill(document)
        }
    }
}

public extension HTMLMarkdown.TextType {

    func hash(into hasher: inout Hasher) {
        switch self {
        case .text:
            hasher.combine("text")
        case .newLine:
            hasher.combine("newLine")
        }
    }

    static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.hashValue == rhs.hashValue
    }
}

public extension HTMLMarkdown.TextUnit {
    
    var linkData: (name: String, link: URL)? {
        guard case let .text(value, styles) = self.type else {
            return nil
        }
        let linkItem = styles.first { $0.getLinkURL != nil }
        guard case let .link(url) = linkItem else {
            return nil
        }
        return (value, url)
    }
}

public extension HTMLMarkdown.UnitType {
    
    func hash(into hasher: inout Hasher) {
        switch self {
        case .document:
            hasher.combine("document")
        case .paragraph:
            hasher.combine("paragraph")
        case .section:
            hasher.combine("section")
        case .blockQuote:
            hasher.combine("blockQuote")
        case .list:
            hasher.combine("list")
        case .listItem:
            hasher.combine("listItem")
        case .codeBlock:
            hasher.combine("codeBlock")
        case .table:
            hasher.combine("table")
        case .tableItem:
            hasher.combine("tableItem")
        case .text:
            hasher.combine("text")
        case .image:
            hasher.combine("image")
        case .thematicBreak:
            hasher.combine("thematicBreak")
        }
    }

    static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.hashValue == rhs.hashValue
    }
}

public extension HTMLMarkdown.UnitStyle {
    
    var getLinkURL: URL? {
        if case let .link(url) = self {
            return url
        }
        return nil
    }
    
    func hash(into hasher: inout Hasher) {
        switch self {
        case .link: hasher.combine("link")
        case .bold: hasher.combine("bold")
        case .code: hasher.combine("code")
        case .strikethrough: hasher.combine("strikethrough")
        case .italic: hasher.combine("italic")
        case .header: hasher.combine("header")
        case .superscriptText: hasher.combine("superscriptText")
        case .subscriptText: hasher.combine("subscriptText")
        }
    }

    static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.hashValue == rhs.hashValue
    }
}
