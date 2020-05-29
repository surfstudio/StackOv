//
//  TagsCollectionView.swift
//  StackoverflowIOS
//
//  Created by Erik Basargin on 22/05/2020.
//  Copyright © 2020 Ephedra Software. All rights reserved.
//

import SwiftUI

struct TagsCollectionView: View {
    var data: [TagModel]
    var elementContent: (TagModel) -> TagView
    
    private let spacing = UIOffset(horizontal: 5, vertical: 5)
    
    init(_ data: [TagModel], elementContent: @escaping (TagModel) -> TagView) {
        self.data = data
        self.elementContent = elementContent
    }
    
    var body: some View {
        GeometryReader { geometry in
            if self.data.isEmpty {
                EmptyView()
            } else {
                self.content(self.flowLayout(for: self.data, preferredWidth: geometry.size.width))
            }
        }
    }
    
    private func content(_ data: [TagsSection]) -> some View {
        VStack(alignment: .leading, spacing: spacing.vertical) {
            ForEach(data) { section in
                HStack(alignment: .bottom, spacing: self.spacing.horizontal) {
                    ForEach(section.items) {
                        self.elementContent($0)
                    }
                    Spacer()
                }
                .fixedSize(horizontal: false, vertical: true)
            }
        }
        .fixedSize(horizontal: false, vertical: true)
    }
    
    private func flowLayout(for elements: [TagModel], preferredWidth: CGFloat) -> [TagsSection] {
        var state = FlowLayout(containerWidth: preferredWidth, spacing: spacing)
        var result: [TagsSection] = [TagsSection(id: .zero)]
        var iterator: Int = .zero
        for element in elements {
            if state.add(element: element.size) {
                iterator += 1
                result += [TagsSection(id: iterator, items: [element])]
            } else {
                result[iterator].items += [element]
            }
        }
        return result
    }
}

fileprivate final class TagsSection: Identifiable {
    let id: Int
    var items: [TagModel]
    
    init(id: Int, items: [TagModel] = []) {
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

    mutating func add(element size: CGSize) -> Bool {
        if current.x + size.width > containerWidth {
            current.x = 0
            current.y += lineHeight + spacing.vertical
            lastContainerHeight += lineHeight + spacing.vertical
            lineHeight = 0
            return true
        }
        defer {
            lineHeight = max(lineHeight, size.height)
            current.x += size.width + spacing.horizontal
        }
        return false //CGRect(origin: current, size: size)
    }
}
