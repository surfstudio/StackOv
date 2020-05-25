//
//  CollectionView.swift
//  StackoverflowIOS
//
//  Created by Erik Basargin on 07/05/2020.
//  Copyright © 2020 Ephedra Software. All rights reserved.
//

import SwiftUI

struct CollectionView<Elements, Content>: View where Elements: RandomAccessCollection, Content: View, Elements.Element: Identifiable {
    private typealias ElementsSizes = [Elements.Element.ID: CGSize]
    private typealias FlowLayoutInfo = (containerSize: CGSize, offsets: ElementsSizes)
    
    var data: Elements
    var elementContent: (Elements.Element) -> Content
    
    @State private var sizes: ElementsSizes = [:]
    
    var body: some View {
        GeometryReader { geometry in
            self.content(flowInfo:
                self.flowLayout(for: self.data, preferredWidth: geometry.size.width, sizes: self.sizes)
            )
        }
    }
    
    private func content(flowInfo: FlowLayoutInfo) -> some View {
        ZStack(alignment: .topLeading) {
            ForEach(self.data) {
                PropagateElementSize(id: $0.id, content: self.elementContent($0))
                    .offset(flowInfo.offsets[$0.id] ?? .zero)
            }
            PropagateSize(content: Color.clear.frame(width: flowInfo.containerSize.width, height: flowInfo.containerSize.height))
        }
        .onPreferenceChange(ElementSizeKey<Elements.Element.ID>.self) {
            self.sizes = $0
        }
    }
    
    private func flowLayout(for elements: Elements, preferredWidth: CGFloat, sizes: ElementsSizes) -> FlowLayoutInfo {
        var state = FlowLayout(containerWidth: preferredWidth)
        var result: ElementsSizes = [:]
        for element in elements {
            let rect = state.add(element: sizes[element.id] ?? .zero)
            result[element.id] = CGSize(width: rect.origin.x, height: rect.origin.y)
        }
        return (state.containerSize, result)
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

    init(containerWidth: CGFloat, spacing: UIOffset = UIOffset(horizontal: 5, vertical: 5)) {
        self.spacing = spacing
        self.containerWidth = containerWidth
    }

    mutating func add(element size: CGSize) -> CGRect {
        if current.x + size.width > containerWidth {
            current.x = 0
            current.y += lineHeight + spacing.vertical
            lastContainerHeight += lineHeight + spacing.vertical
            lineHeight = 0
        }
        defer {
            lineHeight = max(lineHeight, size.height)
            current.x += size.width + spacing.horizontal
        }
        return CGRect(origin: current, size: size)
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

struct CollectionViewSizeKey: PreferenceKey {
    typealias Value = CGSize
    
    static var defaultValue: CGSize { .zero }
    
    static func reduce(value: inout CGSize, nextValue: () -> CGSize) {
        value = nextValue()
    }
}

struct PropagateSize<Content: View>: View {
    var content: Content
    
    var body: some View {
        content.background(GeometryReader { geometry in
            Color.clear.preference(key: CollectionViewSizeKey.self, value: geometry.size)
        })
    }
}
