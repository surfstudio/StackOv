//
//  ThreadItemNavigationLinkStyle.swift
//  StackOv (Components module)
//
//  Created by  Erik Basargin
//  Copyright © 2021 Erik Basargin. All rights reserved.
//

import SwiftUI
import Palette

public struct ThreadItemNavigationLinkStyle: ButtonStyle {
    
    // MARK: - Initialization
    
    public init() {}
    
    // MARK: - View methods
    
    public func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .shadow(color: Color.shadow, radius: 16, x: 0, y: 14)
            .animation(.default)
            .opacity(configuration.isPressed ? 0.8 : 1)
    }
}

// MARK: - Colors

fileprivate extension Color {
    
    static let shadow = Palette.darkShadow.opacity(0.18) | Color.clear
}
