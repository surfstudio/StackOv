//
//  ImageView.swift
//  StackOv (Components module)
//
//  Created by Erik Basargin
//  Copyright © 2021 Erik Basargin. All rights reserved.
//

import SwiftUI
import HTMLMarkdown
import Kingfisher

extension MarkdownPostView {
    
    struct ImageView: StyleableUnitView {
        
        // MARK: - Nested types
        
        private struct ImageHandler: ImageModifier {
            @Binding var handler: UIImage?
            
            func modify(_ image: UIImage) -> UIImage {
                handler = image
                return image
            }
        }
        
        // MARK: - States
        
        @State private var image: UIImage?
        @State private var showImage: UIImage?
        
        // MARK: - Properties
        
        let style: Style
        let unit: HTMLMarkdown.Unit
        
        // MARK: - View
        
        var body: some View {
            if case let .image(url, _, width, height) = unit.type {
                KFImage(source: .network(url), options: [.cacheMemoryOnly, .imageModifier(ImageHandler(handler: $image))])
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .modifier(ImageViewSizeModifier(width: width, height: height))
                    .contextMenu {
                        Button("Copy") {
                            UIPasteboard.general.image = image
                        }
                        Button("More") {
                            showImage = image
                        }
                    }
                    .sheet(item: $showImage) { image in
                        ActivityView(activityItems: [image])
                    }
            } else {
                fatalError("ImageView has got unsupported unit \(unit)")
            }
        }
    }

}

// MARK: - Extensions

fileprivate struct ImageViewSizeModifier: ViewModifier {
    
    let width: CGFloat?
    let height: CGFloat?
    
    @ViewBuilder
    func body(content: Content) -> some View {
        switch (width, height) {
        case (nil, nil):
            content
                .frame(height: 300)
        case let (width, height):
            content
                .frame(width: width, height: height)
        }
    }
}
