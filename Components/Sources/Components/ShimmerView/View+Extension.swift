//
//  View+Extension.swift
//  StackOv (Components module)
//
//  Created by Владислав Климов
//  Copyright © 2021 Erik Basargin. All rights reserved.
//

import SwiftUI

extension View {
    
    public func shimmer(isActive: Bool) -> some View {
        modifier(ShimmerModifier(isActive: isActive))
    }
}
