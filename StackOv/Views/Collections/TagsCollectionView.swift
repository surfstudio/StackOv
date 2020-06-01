//
//  TagsCollectionView.swift
//  StackOv
//
//  Created by Erik Basargin on 22/05/2020.
//  Copyright © 2020 Ephedra Software. All rights reserved.
//

import SwiftUI

struct TagsCollectionView: View {
    var data: [TagModel]
    var preferredWidth: CGFloat?
    var alignment: VerticalAlignment?
    var elementContent: (TagModel) -> TagView
    
    @State private var frame: CGSize = .zero
    private let spacing = UIOffset(horizontal: 5, vertical: 5)
    
    init(_ data: [TagModel], preferredWidth: CGFloat, alignment: VerticalAlignment = .bottom, elementContent: @escaping (TagModel) -> TagView) {
        self.data = data
        self.preferredWidth = preferredWidth
        self.alignment = alignment
        self.elementContent = elementContent
    }
    
    init(_ data: [TagModel], elementContent: @escaping (TagModel) -> TagView) {
        self.data = data
        self.preferredWidth = nil
        self.alignment = nil
        self.elementContent = elementContent
    }
    
    var body: some View {
        if let width = preferredWidth {
            return AnyView(content(flowLayout(for: data, preferredWidth: width)))
        } else {
            return AnyView(dynamicContent)
        }
    }
    
    var dynamicContent: some View {
        GeometryReader { geometry in
            Group { () -> AnyView in
                let size = self.data.size(preferredWidth: geometry.size.width)
                DispatchQueue.main.async {
                    self.frame = size
                }
                return AnyView(
                    self.content(self.flowLayout(for: self.data, preferredWidth: geometry.size.width))
                )
            }
        }
        .frame(height: frame.height)
    }
    
    private func content(_ data: [TagsSection]) -> some View {
        VStack(alignment: .leading, spacing: spacing.vertical) {
            if alignment == .bottom { Spacer() }
            ForEach(data) { section in
                HStack(spacing: self.spacing.horizontal) {
                    ForEach(section.items) {
                        self.elementContent($0).fixedSize()
                    }
                    Spacer()
                }
                .fixedSize(horizontal: false, vertical: true)
            }
            if alignment == .top { Spacer() }
        }
        .fixedSize(horizontal: false, vertical: true)
//        .onPreferenceChange(ElementSizeKey<String>.self) {
//            $0.sorted(by: { $0.key.split(separator: " ")[1] < $1.key.split(separator: " ")[1] }).forEach { data in
//                print("\(data.key) size", data.value)
//            }
//        }
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
        return false //CGRect(origin: current, size: size)
    }
}

fileprivate extension Array where Element == TagModel {
    func size(preferredWidth: CGFloat) -> CGSize {
        let spacing = UIOffset(horizontal: 5, vertical: 5)
        var state = FlowLayout(containerWidth: preferredWidth, spacing: spacing)
        for element in self {
            state.add(element: element.size)
        }
        return state.containerSize
    }
}
