//
//  CheckmarkView.swift
//  StackOv (HomeFlow module)
//
//  Created by Evgeny Novgorodov
//  Copyright © 2021 Erik Basargin. All rights reserved.
//

import SwiftUI
import Palette
import Icons

public struct CheckmarkView: View {
    
    // MARK: - States
    
    @Environment(\.sizeCategory) var sizeCategory: ContentSizeCategory
    
    // MARK: - Properties
    
    let isSelected: Bool
    let isFilled: Bool
    
    var maxSize: CGSize {
        switch sizeCategory {
        case .extraSmall, .small:
            return CGSize(width: 18, height: 18)
        case .medium, .large:
            return CGSize(width: 20, height: 20)
        case .extraLarge, .extraExtraLarge, .extraExtraExtraLarge:
            return CGSize(width: 24, height: 24)
        case .accessibilityMedium:
            return CGSize(width: 26, height: 26)
        case .accessibilityLarge:
            return CGSize(width: 28, height: 28)
        case .accessibilityExtraLarge, .accessibilityExtraExtraLarge, .accessibilityExtraExtraExtraLarge:
            return CGSize(width: 34, height: 34)
        @unknown default:
            return CGSize(width: 20, height: 20)
        }
    }
    
    // MARK: - Initialization
    
    public init(isSelected: Bool, isFilled: Bool) {
        self.isSelected = isSelected
        self.isFilled = isFilled
    }
    
    // MARK: - View
    
    public var body: some View {
        ZStack {
            if isFilled {
                Circle().stroke(Color.border(isSelected: isSelected), lineWidth: 1)
            }
            
            if isSelected {
                if isFilled {
                    Icons.checkmarkCircleFill.image
                        .resizable()
                } else {
                    Icons.checkmark.image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: maxSize.width * 0.7)
                }
            }
        }
        .frame(width: maxSize.width, height: maxSize.height)
    }
}

// MARK: - Previews

struct CheckmarkView_Previews: PreviewProvider {
    
    static var previews: some View {
        CheckmarkView(isSelected: true, isFilled: true)
    }
}

// MARK: - Colors

fileprivate extension Color {
    
    static func border(isSelected: Bool) -> Color {
        isSelected ? Palette.main : Palette.telegrey
    }
}
