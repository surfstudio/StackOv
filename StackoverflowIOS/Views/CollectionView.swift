//
//  CollectionView.swift
//  StackoverflowIOS
//
//  Created by Erik Basargin on 07/05/2020.
//  Copyright © 2020 Ephedra Software. All rights reserved.
//

import SwiftUI

struct CollectionView<Elements, Content>: View where Elements: RandomAccessCollection, Content: View, Elements.Element: Identifiable {
    private typealias ElementSize = [Elements.Element.ID: CGSize]
    
    var data: Elements
    var elementContent: (Elements.Element) -> Content
    
    @State private var sizes: ElementSize = [:]
    
    var body: some View {
        return GeometryReader { geometry in
            self.content(
                containerSize: geometry.size,
                offsets: self.flowLayout(for: self.data, containerSize: geometry.size, sizes: self.sizes)
            )
        }
    }
    
    private func content(containerSize: CGSize, offsets: ElementSize) -> some View {
        return ZStack(alignment: .topLeading) {
            ForEach(self.data) {
                PropagateSize(id: $0.id, content: self.elementContent($0))
                    .offset(offsets[$0.id] ?? .zero)
            }
            Color.clear.frame(width: containerSize.width, height: containerSize.height)
        }
        .onPreferenceChange(CollectionViewSizeKey<Elements.Element.ID>.self) {
            self.sizes = $0
        }
    }
    
    private func flowLayout(for elements: Elements, containerSize: CGSize, sizes: ElementSize) -> ElementSize {
        var state = FlowLayout(containerSize: containerSize)
        var result: ElementSize = [:]
        for element in elements {
            let rect = state.add(element: sizes[element.id] ?? .zero)
            result[element.id] = CGSize(width: rect.origin.x, height: rect.origin.y)
        }
        return result
    }
}

fileprivate struct FlowLayout {
    let spacing: UIOffset
    let containerSize: CGSize
    
    var current: CGPoint = .zero
    var lineHeight: CGFloat = .zero

    init(containerSize: CGSize, spacing: UIOffset = UIOffset(horizontal: 5, vertical: 5)) {
        self.spacing = spacing
        self.containerSize = containerSize
    }

    mutating func add(element size: CGSize) -> CGRect {
        if current.x + size.width > containerSize.width {
            current.x = 0
            current.y += lineHeight + spacing.vertical
            lineHeight = 0
        }
        defer {
            lineHeight = max(lineHeight, size.height)
            current.x += size.width + spacing.horizontal
        }
        return CGRect(origin: current, size: size)
    }
}

fileprivate struct CollectionViewSizeKey<ID: Hashable>: PreferenceKey {
    typealias Value = [ID: CGSize]
    
    static var defaultValue: [ID: CGSize] { [:] }
    
    static func reduce(value: inout [ID: CGSize], nextValue: () -> [ID: CGSize]) {
        value.merge(nextValue(), uniquingKeysWith: { $1 })
    }
}

fileprivate struct PropagateSize<ID: Hashable, Content: View>: View {
    var id: ID
    var content: Content
    
    var body: some View {
        content
            .background(GeometryReader { geometry in
                Color.clear.preference(key: CollectionViewSizeKey<ID>.self, value: [self.id: geometry.size])
            })
    }
}
