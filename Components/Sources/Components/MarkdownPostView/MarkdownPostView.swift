//
//  MarkdownPostView.swift
//  StackOv (Components module)
//
//  Created by Erik Basargin
//  Copyright © 2021 Erik Basargin. All rights reserved.
//

import SwiftUI
import HTMLMarkdown
import Palette
import Common
import Errors

public struct MarkdownPostView: View {
    
    // MARK: - Nested types
    
    public enum Style: Comparable {
        case post
        case comment
    }
    
    // MARK: - Properties
    
    let value: Result<HTMLMarkdown.Unit, Error>
    let style: Style
    
    // MARK: - Initialization
    
    public init(_ value: Result<HTMLMarkdown.Unit, Error>, style: Style) {
        self.value = value
        self.style = style
    }
    
    // MARK: - View
    
    public var body: some View {
        switch value {
        case let .success(unit):
            DocumentView(style: style, unit: unit)
                .font(style == .post ? .subheadline : .footnote)
                .foregroundColor(Color.foreground)
                .background(Color.background)
                .contextMenu {
                    Button("Copy") {
                        do {
                            UIPasteboard.general.string = try unit.rootElement.text()
                        } catch {
                            GlobalBanner.show(error: PasteboardError.unknown)
                        }
                    }
                }
        case let .failure(error):
            #if DEBUG
            Text(error.localizedDescription)
                .bold()
                .foregroundColor(.red)
            #else
            EmptyView()
            #endif
        }
    }
}

// MARK: - Colors

fileprivate extension Color {
    
    static let foreground = Palette.black | Color.white
    static let background = Palette.bluishwhite | Palette.bluishblack
}

// MARK: - Extensions

public extension MarkdownPostView {
    
    @available(*, deprecated, message: "MarkdownPostView uses only its styles")
    @inlinable func font(_ font: Font?) -> some View {
        self
    }
    
    @available(*, deprecated, message: "MarkdownPostView uses only its styles")
    @inlinable func foregroundColor(_ color: Color?) -> some View {
        self
    }
    
    @available(*, deprecated, message: "MarkdownPostView uses only its styles")
    @inlinable func multilineTextAlignment(_ alignment: TextAlignment) -> some View {
        self
    }

    @available(*, deprecated, message: "MarkdownPostView uses only its styles")
    @inlinable func truncationMode(_ mode: Text.TruncationMode) -> some View {
        self
    }

    @available(*, deprecated, message: "MarkdownPostView uses only its styles")
    @inlinable func lineSpacing(_ lineSpacing: CGFloat) -> some View {
        self
    }

    @available(*, deprecated, message: "MarkdownPostView uses only its styles")
    @inlinable func allowsTightening(_ flag: Bool) -> some View {
        self
    }

    @available(*, deprecated, message: "MarkdownPostView uses only its styles")
    @inlinable func lineLimit(_ number: Int?) -> some View {
        self
    }

    @available(*, deprecated, message: "MarkdownPostView uses only its styles")
    @inlinable func minimumScaleFactor(_ factor: CGFloat) -> some View {
        self
    }

    @available(*, deprecated, message: "MarkdownPostView uses only its styles")
    @available(iOS 14.0, macOS 11.0, tvOS 14.0, watchOS 7.0, *)
    @inlinable func textCase(_ textCase: Text.Case?) -> some View {
        self
    }
}
