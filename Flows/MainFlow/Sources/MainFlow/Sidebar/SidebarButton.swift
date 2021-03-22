//
//  SidebarButton.swift
//  StackOv (MainFlow module)
//
//  Created by Erik Basargin
//  Copyright © 2021 Erik Basargin. All rights reserved.
//

import SwiftUI
import Palette

struct SidebarButton: View {
    
    // MARK: - States
    
    @Environment(\.sizeCategory) var sizeCategory: ContentSizeCategory
    @Binding var globalState: MainBar.ItemType
    
    // MARK: - Properties
    
    let type: MainBar.ItemType
    var isSelected: Bool { type == globalState }
    var labelMaxSize: CGSize {
        sizeCategory.isAccessibilityCategory
            ? CGSize(width: 30, height: 30)
            : CGSize(width: 20, height: 20)
    }
    var fontSize: CGFloat {
        switch sizeCategory {
        case .extraSmall, .small, .medium, .large, .extraLarge, .extraExtraLarge, .extraExtraExtraLarge:
            return 13
        case .accessibilityMedium:
            return 15
        case .accessibilityLarge, .accessibilityExtraLarge:
            return 16
        case .accessibilityExtraExtraLarge:
            return 17
        case .accessibilityExtraExtraExtraLarge:
            return 18
        @unknown default:
            assertionFailure()
            return 13
        }
    }
    
    // MARK: - Initialization
    
    init(_ type: MainBar.ItemType, state: Binding<MainBar.ItemType>) {
        self.type = type
        self._globalState = state
    }
    
    // MARK: - View
    
    var body: some View {
        Button(action: { globalState = type }) {
            HStack(alignment: .center, spacing: 13) {
                type.image
                    .resizable()
                    .frame(maxWidth: labelMaxSize.width, maxHeight: labelMaxSize.height)
                    .aspectRatio(contentMode: .fit)
                    .foregroundColor(Color.iconForeground(by: isSelected))

                Text(type.title)
                    .font(.system(size: fontSize, weight: .medium))
                    .foregroundColor(Color.textForeground(by: isSelected))
            }

            Spacer()
        }
        .padding(.vertical, 9)
        .padding(.horizontal, 13)
        .background(Color.background(by: isSelected))
        .cornerRadius(4)
        .frame(height: 38)
    }
}

// MARK: - Previews

struct SidebarButton_Previews: PreviewProvider {
    
    static var previews: some View {
        SidebarButton(.home, state: .constant(.home))
            .padding()
            .background(Palette.grayblue)
            .previewLayout(.sizeThatFits)
    }
}

// MARK: - Colors

fileprivate extension Color {
    
    static func iconForeground(by selected: Bool) -> Self {
        selected
            ? Palette.lightBlack | Color.white
            : Palette.slateGrayLight | Palette.telegrey
    }
    
    static func textForeground(by selected: Bool) -> Self {
        selected
            ? Palette.lightBlack | Color.white
            : Palette.slateGrayLight | Palette.gainsboro
    }
    
    static func background(by selected: Bool) -> Self {
        selected
            ? Palette.lightDeepGray | Color.white.opacity(0.05)
            : .clear
    }
}
