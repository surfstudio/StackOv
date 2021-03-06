//
//  ShimmerModifier.swift
//  StackOv (Components module)
//
//  Created by Владислав Климов
//  Copyright © 2021 Erik Basargin. All rights reserved.
//

import SwiftUI

struct ShimmerModifier: ViewModifier {
    
    // MARK: - Properties
    
    let isActive: Bool
    
    // MARK: - View Modifier
    
    @ViewBuilder func body(content: Content) -> some View {
        if isActive {
            content.overlay(ShimmerView().clipped())
        } else {
            content
        }
    }
}
