//
//  AdaptiveTagsCollectionView.swift
//  StackOv (Components module)
//
//  Created by  Erik Basargin
//  Copyright © 2021 Erik Basargin. All rights reserved.
//

import SwiftUI

public struct AdaptiveTagsCollectionView: View {
    
    public typealias CollectionSizeHandler = (_ mainContentWidth: CGFloat) -> CGFloat
    
    @Environment(\.mainContentSize) var mainContentSize
    @State private var preferredWidth: CGFloat = .zero
    
    let data: [String]
    let alignment: VerticalAlignment?
    let elementContent: (String) -> TagButton
    let prepareCollectionWidth: CollectionSizeHandler
    
    public init(
        _ data: [String],
        alignment: VerticalAlignment = .bottom,
        elementContent: @escaping (String) -> TagButton,
        prepareCollectionWidth: @escaping CollectionSizeHandler) {
        self.data = data
        self.alignment = alignment
        self.elementContent = elementContent
        self.prepareCollectionWidth = prepareCollectionWidth
    }
    
    public var body: some View {
        TagsCollectionView(data, alignment: alignment ?? .bottom, preferredWidth: $preferredWidth, elementContent: elementContent)
            .onAppear {
                preferredWidth = prepareCollectionWidth(mainContentSize.width)
            }
            .onChange(of: mainContentSize) { value in
                preferredWidth = prepareCollectionWidth(value.width)
            }
    }
}
