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

    @Binding var globalState: MainBar.ItemType
    
    let type: MainBar.ItemType
    var isSelected: Bool { type == globalState }
    
    init(_ type: MainBar.ItemType, state: Binding<MainBar.ItemType>) {
        self.type = type
        self._globalState = state
    }
    
    var body: some View {
        Button(action: { globalState = type }) {
            HStack(alignment: .center, spacing: 13) {
                type.image
                    .resizable()
                    .frame(maxWidth: 20, maxHeight: 20)
                    .aspectRatio(contentMode: .fit)
                    .foregroundColor(Color.iconForeground(by: isSelected))

                Text(type.title)
                    .font(.system(size: 13, weight: .medium))
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
