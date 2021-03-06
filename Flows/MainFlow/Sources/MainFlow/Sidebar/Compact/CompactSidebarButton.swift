//
//  CompactSidebarButton.swift
//  StackOv (MainFlow module)
//
//  Created by Владислав Климов
//  Copyright © 2021 Erik Basargin. All rights reserved.
//

import SwiftUI
import Palette

struct CompactSidebarButton: View {
    
    // MARK: - States
    
    @Environment(\.sizeCategory) var sizeCategory: ContentSizeCategory
    @Binding var globalState: MainBar.ItemType
    
    // MARK: - Properties
    
    let type: MainBar.ItemType
    var isSelected: Bool { type == globalState }
    var contentHeight: CGFloat {
        sizeCategory.isAccessibilityCategory ? 60 : 38
    }
    var labelMaxSize: CGSize {
        sizeCategory.isAccessibilityCategory
            ? CGSize(width: 30, height: 30)
            : CGSize(width: 20, height: 20)
    }
    
    // MARK: - Initialization
    
    init(_ type: MainBar.ItemType, state: Binding<MainBar.ItemType>) {
        self.type = type
        self._globalState = state
    }
    
    // MARK: - View
    
    var body: some View {
        HStack(alignment: .center, spacing: .zero) {
            Spacer()
            
            Button(action: { globalState = type }) {
                type.image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .foregroundColor(Color.iconForeground(by: isSelected))
            }
            .frame(maxWidth: labelMaxSize.width, maxHeight: labelMaxSize.height)
            
            Spacer()
        }
        .frame(height: contentHeight)
        .background(Color.background(by: isSelected))
    }
}

// MARK: - Previews

struct CompactSidebarButton_Previews: PreviewProvider {
    
    static var previews: some View {
        CompactSidebarButton(.home, state: .constant(.home))
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

    static func background(by selected: Bool) -> Self {
        selected
            ? Palette.lightDeepGray | Color.white.opacity(0.05)
            : .clear
    }
}
