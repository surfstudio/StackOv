//
//  TagCollection.swift
//  StackOv (Components module)
//
//  Created by Erik Basargin
//  Copyright © 2021 Erik Basargin. All rights reserved.
//

import SwiftUI

public struct TagsCollectionView: View {
    
    let data: [String]
    let preferredWidth: CGFloat
    let alignment: VerticalAlignment?
    let elementContent: (String) -> TagButton
    
    @State private var frame: CGSize = .zero
    private let spacing = UIOffset(horizontal: 6, vertical: 6)
    
    public init(_ data: [String], preferredWidth: CGFloat, alignment: VerticalAlignment = .bottom, elementContent: @escaping (String) -> TagButton) {
        self.data = data
        self.preferredWidth = preferredWidth
        self.alignment = alignment
        self.elementContent = elementContent
    }
    
    public var body: some View {
        content(flowLayout(for: data, preferredWidth: preferredWidth))
    }
    
    private func content(_ data: [TagsSection]) -> some View {
        VStack(alignment: .leading, spacing: spacing.vertical) {
            if alignment == .bottom { Spacer() }
            ForEach(data.suffix(2)) { section in
                HStack(spacing: self.spacing.horizontal) {
                    ForEach(section.items, id: \.self) {
                        self.elementContent($0).fixedSize()
                    }
                    Spacer()
                }
                .fixedSize(horizontal: false, vertical: true)
            }
            if alignment == .top { Spacer() }
        }
        .fixedSize(horizontal: false, vertical: true)
    }
    
    private func flowLayout(for elements: [String], preferredWidth: CGFloat) -> [TagsSection] {
        var state = FlowLayout(containerWidth: preferredWidth, spacing: spacing)
        var result: [TagsSection] = [TagsSection(id: .zero)]
        var iterator: Int = .zero
        for element in elements {
            if state.add(element: TagButton.size(for: element)) {
                iterator += 1
                result += [TagsSection(id: iterator, items: [element])]
            } else {
                result[iterator].items += [element]
            }
        }
        return result
    }
}

fileprivate struct ElementSizeKey<ID: Hashable>: PreferenceKey {
    typealias Value = [ID: CGSize]
    
    static var defaultValue: [ID: CGSize] { [:] }
    
    static func reduce(value: inout [ID: CGSize], nextValue: () -> [ID: CGSize]) {
        value.merge(nextValue(), uniquingKeysWith: { $1 })
    }
}

fileprivate struct PropagateElementSize<ID: Hashable, Content: View>: View {
    var id: ID
    var content: Content
    
    var body: some View {
        content.background(GeometryReader { geometry in
            Color.clear.preference(key: ElementSizeKey<ID>.self, value: [self.id: geometry.size])
        })
    }
}

fileprivate final class TagsSection: Identifiable {
    let id: Int
    var items: [String]
    
    init(id: Int, items: [String] = []) {
        self.id = id
        self.items = items
    }
}

fileprivate struct FlowLayout {
    let spacing: UIOffset
    let containerWidth: CGFloat
    
    var current: CGPoint = .zero
    var lineHeight: CGFloat = .zero
    var lastContainerHeight: CGFloat = .zero
    var containerSize: CGSize {
        .init(width: containerWidth, height: lastContainerHeight + lineHeight)
    }

    init(containerWidth: CGFloat, spacing: UIOffset) {
        self.spacing = spacing
        self.containerWidth = containerWidth
    }

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

