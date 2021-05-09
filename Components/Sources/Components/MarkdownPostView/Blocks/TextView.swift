//
//  TextView.swift
//  StackOv (Components module)
//
//  Created by Erik Basargin
//  Copyright © 2021 Erik Basargin. All rights reserved.
//

import SwiftUI
import HTMLMarkdown
import Common
import Errors

extension MarkdownPostView {
    
    struct TextView: StyleableUnitView {
        
        // MARK: - States
        
        @State private var selectedUrl: URL?
        
        // MARK: - Properties
        
        let style: Style
        let unit: HTMLMarkdown.Unit
        
        // MARK: - View
        
        var body: some View {
            if case let .text(children) = unit.type {
                generateContent(with: children)
                    .sheet(item: $selectedUrl) { url in
                        SafariView(url: url)
                    }
            } else {
                fatalError("TextView has got unsupported unit \(unit)")
            }
        }
        
        // MARK: - Methods
        
        func generateContent(with items: [HTMLMarkdown.TextUnit]) -> some View {
            var links: [(name: String, link: URL)] = []
            return generateTextView(items: items, links: &links)
                .contextMenuIfNeeded(links: links) {
                    ForEach(links, id: \.1) { name, url in
                        Button("Link: \"\(name)\"") {
                            open(url: url)
                        }
                    }
                    Button("Full copy") {
                        do {
                            UIPasteboard.general.string = try unit.rootElement.text()
                        } catch {
                            GlobalBanner.show(error: PasteboardError.unknown)
                        }
                    }
                }
        }
        
        @ViewBuilder
        func generateTextView(items: [HTMLMarkdown.TextUnit], links: inout [(name: String, link: URL)]) -> some View {
            if items.count == 1, let linkData = items.first?.linkData {
                Button(action: { open(url: linkData.link) }) {
                    items.map { $0.type.textView(viewStyle: style, links: &links) }.reduce(Text("")) { $0 + $1 }
                }
            } else {
                items.map { $0.type.textView(viewStyle: style, links: &links) }.reduce(Text("")) { $0 + $1 }
            }
        }
        
        func open(url: URL) {
            guard UIApplication.shared.canOpenURL(url), ["http", "https"].contains(url.scheme ?? "") else {
                UIPasteboard.general.string = url.absoluteString
                GlobalBanner.show(error: OpenURLError.canNotBeOpened(url))
                return
            }
            if UIDevice.current.userInterfaceIdiom.isMacCatalyst {
                UIApplication.shared.tryOpen(url: url) { isOpened in
                    if !isOpened {
                        UIPasteboard.general.string = url.absoluteString
                        GlobalBanner.show(error: OpenURLError.canNotBeOpened(url))
                    }
                }
            } else {
                selectedUrl = url
            }
        }
    }
     
}

// MARK: - Extensions

fileprivate extension View {
    
    @ViewBuilder
    func contextMenuIfNeeded<MenuItems: View>(links: [(name: String, link: URL)],
                                              @ViewBuilder menuItems: () -> MenuItems) -> some View {
        if links.isEmpty {
            self
        } else {
            contextMenu(menuItems: menuItems)
        }
    }
}

fileprivate extension HTMLMarkdown.TextType {
    
    func textView(viewStyle: MarkdownPostView.Style, links: inout [(name: String, link: URL)]) -> Text {
        switch self {
        case .newLine:
            return Text("\n")
        case let .text(value, styles):
            var text = Text(value)
            for style in styles {
                switch style {
                case .code:
                    text = text
                        .font(.custom("Menlo-Regular",
                                      size: viewStyle == .post ? 15 : 13,
                                      relativeTo: viewStyle == .post ? .subheadline : .footnote))
                        .fontWeight(.regular)
                case let .link(url):
                    links.append((value, url))
                    text = text.underline()
                case .bold:
                    text = text.bold()
                case .strikethrough:
                    text = text.strikethrough()
                case .italic:
                    text = text.italic()
                case let .header(level):
                    switch level {
                    case 1:
                        text = text.font(.title)
                    case 2:
                        text = text.font(.title2)
                    case 3:
                        text = text.font(.title3)
                    default:
                        break
                    }
                case .superscriptText:
                    text = text.baselineOffset(5).font(.caption2)
                case .subscriptText:
                    text = text.baselineOffset(-5).font(.caption2)
                }
            }
            return text
        }
    }
}
