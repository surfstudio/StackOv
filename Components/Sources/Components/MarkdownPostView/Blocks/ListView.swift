//
//  ListView.swift
//  StackOv (Components module)
//
//  Created by Erik Basargin
//  Copyright © 2021 Erik Basargin. All rights reserved.
//

import SwiftUI
import HTMLMarkdown

// MARK: - ListView

extension MarkdownPostView {
    
    struct ListView: StyleableUnitView {
        
        // MARK: - Properties
        
        let style: Style
        let unit: HTMLMarkdown.Unit
        
        // MARK: - View
        
        var body: some View {
            if case let .list(style) = unit.type {
                content(style: style)
            } else {
                fatalError("ListView has got unsupported unit \(unit)")
            }
        }
        
        // MARK: - View methods
        
        func content(style: HTMLMarkdown.ListStyle) -> some View {
            VStack(alignment: .leading, spacing: 5) {
                switch style {
                case let .ordered(start):
                    orderedList(start: start)
                case .unordered:
                    unorderedList()
                }
            }
        }
        
        func orderedList(start: Int) -> some View {
            ForEach(Array(zip((0..<unit.children.count), unit.children)), id: \.1.id) { number, child in
                ListItemView(style: style, unit: child, number: number + start)
            }
        }
        
        func unorderedList() -> some View {
            ForEach(unit.children) { child in
                ListItemView(style: style, unit: child, number: nil)
            }
        }
    }
    
}

// MARK: - ListItemView

fileprivate extension MarkdownPostView {
    
    struct ListItemView: StyleableUnitView {
        
        // MARK: - Properties
        
        let style: Style
        let unit: HTMLMarkdown.Unit
        let number: Int?
        
        // MARK: - View
        
        var body: some View {
            if case let .listItem(style) = unit.type {
                switch style {
                case .descriptionTitle:
                    descriptionTitle
                case .descriptionDetails:
                    descriptionDetails
                case .item:
                    item
                }
            } else {
                fatalError("ListItemView has got unsupported unit \(unit)")
            }
        }
        
        var descriptionTitle: some View {
            RepetitiveView(style: style, unit: unit)
        }
        
        var descriptionDetails: some View {
            RepetitiveView(style: style, unit: unit)
                .padding(.trailing, 10)
        }
        
        var item: some View {
            HStack(alignment: .top, spacing: 10) {
                Text(number == nil ? "●" : "\(number!)")
                    .multilineTextAlignment(.center)
                    .font(number == nil
                            ? .custom("Helvetica Neue", size: 12, relativeTo: .caption2)
                            : (style == .post ? .subheadline : .footnote))
                
                RepetitiveView(style: style, unit: unit)
            }
        }
    }
    
}
