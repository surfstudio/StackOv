//
//  TableView.swift
//  StackOv (Components module)
//
//  Created by Erik Basargin
//  Copyright © 2021 Erik Basargin. All rights reserved.
//

import SwiftUI
import HTMLMarkdown
import Palette
import Common
import Errors

// MARK: - TableView

extension MarkdownPostView {
    
    struct TableView: StyleableUnitView {
        
        // MARK: - Properties
        
        let style: Style
        let spacing: CGFloat = 1
        let unit: HTMLMarkdown.Unit
        
        // MARK: - View
        
        var body: some View {
            if case let .table(numberColumns) = unit.type {
                content(numberColumns: numberColumns)
                    .contextMenu {
                        Button("Copy of the table") {
                            do {
                                UIPasteboard.general.string = try unit.htmlElement.text()
                            } catch {
                                GlobalBanner.show(error: PasteboardError.unknown)
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
            } else {
                fatalError("TableView has got unsupported unit \(unit)")
            }
        }
        
        // MARK: - View methods
        
        func content(numberColumns: Int) -> some View {
            LazyVGrid(columns: getColumns(with: numberColumns), spacing: spacing) {
                ForEach(unit.children) {
                    TableItemView(style: style, unit: $0)
                }
            }
            .background(Color.mainBackground)
            .border(Color.mainBackground)
        }
        
        // MARK: - Methods
        
        func getColumns(with number: Int) -> [GridItem] {
            Array(repeating: GridItem(.flexible(), spacing: spacing), count: number)
        }
    }
    
}

// MARK: - TableItemView

fileprivate extension MarkdownPostView {
    
    struct TableItemView: StyleableUnitView {
        
        // MARK: - Properties
        
        let style: Style
        let unit: HTMLMarkdown.Unit
        
        // MARK: - View
        
        var body: some View {
            if case let .tableItem(isHeader, _) = unit.type {
                HStack(spacing: .zero) {
                    RepetitiveView(style: style, unit: unit)
                        .padding(.vertical, 5)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color.background(isHeader: isHeader))
                .foregroundColor(Color.foreground(isHeader: isHeader))
            } else {
                fatalError("TableItemView has got unsupported unit \(unit)")
            }
        }
    }
    
}

// MARK: - Colors

fileprivate extension Color {
    
    static let mainBackground = Palette.main.opacity(0.12) | Color.white.opacity(0.08)
    
    static func background(isHeader: Bool) -> Color {
        isHeader
            ? (Palette.main.opacity(0.12) | Color.white.opacity(0.08))
            : (Palette.bluishwhite | Palette.bluishblack)
    }
    
    static func foreground(isHeader: Bool) -> Color {
        (isHeader ? Palette.main : Palette.black) | .white
    }
}
