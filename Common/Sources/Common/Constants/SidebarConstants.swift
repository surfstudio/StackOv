//
//  SidebarConstants.swift
//  StackOv (Common module)
//
//  Created by Владислав Климов
//  Copyright © 2021 Erik Basargin. All rights reserved.
//

import SwiftUI

public enum SidebarConstants {
    static let regularWidth: CGFloat = 210
    static let compactNormalWidth: CGFloat = 50
    static let compactAccessibilityWidth: CGFloat = 70
    
    public static func sidebarWidth(isRegular: Bool, isAccessibility: Bool) -> CGFloat {
        if isRegular {
            return SidebarConstants.regularWidth
        } else if isAccessibility {
            return SidebarConstants.compactAccessibilityWidth
        } else {
            return SidebarConstants.compactNormalWidth
        }
    }
}
