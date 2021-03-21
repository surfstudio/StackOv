//
//  [NAME].swift
//  StackOv ([NAME] module)
//
//  Created by Владислав Климов
//  Copyright © 2021 Erik Basargin. All rights reserved.
//

import SwiftUI

public struct ShimmerModifier: ViewModifier {
    
    // MARK: - Properties
    
    let isActive: Bool
    
    // MARK: - View Modifier
    
    @ViewBuilder
    public func body(content: Content) -> some View {
        if isActive {
            content.overlay(ShimmerView().clipped())
        } else {
            content
        }
    }
    
}
