//
//  TagsCollectionView.swift
//  StackOv (Components module)
//
//  Created by Владислав Климов
//  Copyright © 2021 Erik Basargin. All rights reserved.
//

import SwiftUI

struct TagsCollectionView: View {

    // MARK: - Properties

    let data: [String]
    let preferredWidth: CGFloat
    let alignment: VerticalAlignment?
    let elementContent: (String) -> TagButton

    @State private var frame: CGSize = .zero
    private let spacing = UIOffset(horizontal: 6, vertical: 6)

    // MARK: - Initialization

    init(_ data: [String], preferredWidth: CGFloat, alignment: VerticalAlignment = .bottom, elementContent: @escaping (String) -> TagButton) {
        self.data = data
        self.preferredWidth = preferredWidth
        self.alignment = alignment
        self.elementContent = elementContent
    }

    // MARK: - Views

    public var body: some View {
        content(flowLayout(for: data, preferredWidth: preferredWidth))
    }

    private func content(_ data: [TagsSection]) -> some View {
        VStack(alignment: .leading, spacing: spacing.vertical) {
            if alignment == .bottom {
                Spacer()
            }

            ForEach(data.suffix(2)) { section in
                HStack(spacing: self.spacing.horizontal) {
                    ForEach(section.items, id: \.self) {
                        self.elementContent($0).fixedSize()
                    }
                }.fixedSize(horizontal: false, vertical: true)
            }

            if alignment == .top {
                Spacer()
            }
        }.fixedSize(horizontal: false, vertical: true)
    }

    private func flowLayout(for elements: [String], preferredWidth: CGFloat) -> [TagsSection] {
        var state = FlowLayout(containerWidth: preferredWidth, spacing: spacing)
        var result: [TagsSection] = [TagsSection(id: .zero)]
        var iterator: Int = .zero
        for element in elements {
            if state.add(element: TagButton.size(for: element, style: elementContent(element).style)) {
                iterator += 1
                result += [TagsSection(id: iterator, items: [element])]
            } else {
                result[iterator].items += [element]
            }
        }
        return result
    }

}

// MARK: - Nested Types

fileprivate final class TagsSection: Identifiable {

    // MARK: - Properties

    let id: Int
    var items: [String]

    // MARK: - Initialization

    init(id: Int, items: [String] = []) {
        self.id = id
        self.items = items
    }

}

fileprivate struct FlowLayout {

    // MARK: - Properties

    let spacing: UIOffset
    let containerWidth: CGFloat
    
    var current: CGPoint = .zero
    var lineHeight: CGFloat = .zero
    var lastContainerHeight: CGFloat = .zero
    var containerSize: CGSize {
        .init(width: containerWidth, height: lastContainerHeight + lineHeight)
    }

    // MARK: -Initialization

    init(containerWidth: CGFloat, spacing: UIOffset) {
        self.spacing = spacing
        self.containerWidth = containerWidth
    }

    // MARK: - Methods

    @discardableResult
    mutating func add(element size: CGSize) -> Bool {
        defer {
            lineHeight = max(lineHeight, size.height)
            current.x += size.width + spacing.horizontal
        }
        if current.x + size.width > containerWidth {
            current.x = 0
            current.y += lineHeight + spacing.vertical
            lastContainerHeight += lineHeight + spacing.vertical
            lineHeight = 0
            return true
        }
        return false
    }

}
