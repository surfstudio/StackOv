//
//  SidebarButton.swift
//  StackOv
//
//  Created by Erik Basargin
//  Copyright © 2021 Erik Basargin. All rights reserved.
//

import SwiftUI
import Palette

struct SidebarButton: View {

    @Binding var globalState: MainBar.ItemType
    @State private var hovered = false
    
    private let type: MainBar.ItemType
    
    init(_ type: MainBar.ItemType, state: Binding<MainBar.ItemType>) {
        self.type = type
        self._globalState = state
    }
    
    var body: some View {
        Button(action: {
            globalState = type
        }) {
            HStack(alignment: .center, spacing: 13) {
                Image(systemName: type.image)
                    .frame(width: 20, height: 20)
                
                Text(type.title)
                    .font(.system(size: 13, weight: .medium))
            }
            .foregroundColor(Color.foreground)
            
            Spacer()
        }
        .padding(EdgeInsets(top: 9, leading: 13, bottom: 9, trailing: 13))
        .background(Color.background(by: type == globalState))
        .cornerRadius(4)
        .disabled(type == globalState)
        .scaleEffect(hovered ? 1.05 : 1.0)
        .animation(.default)
        .onHover { isHovered in
            self.hovered = isHovered
        }
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
    
    static let foreground = Palette.white
    static func background(by pressed: Bool) -> Self {
        pressed ? Palette.white.opacity(0.05) : .clear
    }
}
