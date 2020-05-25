//
//  TagsCollectionView.swift
//  StackoverflowIOS
//
//  Created by Erik Basargin on 22/05/2020.
//  Copyright © 2020 Ephedra Software. All rights reserved.
//

import SwiftUI

struct TagsCollectionView: View {
    typealias ElementsSizes = [TagModel.ID: CGSize]
    typealias FlowLayoutInfo = (containerSize: CGSize, offsets: ElementsSizes)
    
    var data: [TagModel]
    var elementContent: (TagModel) -> TagView
    
    init(_ data: [TagModel], elementContent: @escaping (TagModel) -> TagView) {
        self.data = data
        self.elementContent = elementContent
    }
    
    @State private var contentSize: CGSize = .zero
    private var layoutController = LayoutController()
    
    var body: some View {
        GeometryReader { geometry in
            self.content(flowInfo: self.layoutController.configureLayout(
                for: self.data,
                preferredWidth: geometry.size.width,
                contentSize: self.$contentSize
            ))
        }
        .frame(height: contentSize.height)
    }
    
    private func content(flowInfo: FlowLayoutInfo) -> some View {
        ForEach(self.data) {
            self.elementContent($0)
                .offset(flowInfo.offsets[$0.id] ?? .zero)
        }
    }
    
    private func flowLayout(for elements: [TagModel], preferredWidth: CGFloat) -> FlowLayoutInfo {
        var state = FlowLayout(containerWidth: preferredWidth)
        var result: ElementsSizes = [:]
        for element in elements {
            let rect = state.add(element: element.size)
            result[element.id] = CGSize(width: rect.origin.x, height: rect.origin.y)
        }
        DispatchQueue.main.async {
            self.contentSize = state.containerSize
        }
        return (state.containerSize, result)
    }
    
    final class LayoutController {
        @Binding var contentSize: CGSize
        
        private var flowInfo: FlowLayoutInfo?
        
        init() {
            _contentSize = Binding<CGSize>(get: { .zero }, set: { _ in })
        }
        
        @discardableResult
        func configureLayout(for elements: [TagModel], preferredWidth: CGFloat, contentSize: Binding<CGSize>) -> FlowLayoutInfo {
            _contentSize = contentSize
            if let info = flowInfo { return info }
            
            var state = FlowLayout(containerWidth: preferredWidth)
            var result: ElementsSizes = [:]
            for element in elements {
                let rect = state.add(element: element.size)
                result[element.id] = CGSize(width: rect.origin.x, height: rect.origin.y)
            }
            if contentSize.wrappedValue != state.containerSize {
                DispatchQueue.main.async {
                    self.contentSize = state.containerSize
                }
            }
            return (state.containerSize, result)
        }
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
