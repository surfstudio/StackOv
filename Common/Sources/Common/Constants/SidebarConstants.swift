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
    
    public static func sidebarWidth(style: SidebarStyle, isAccessibility: Bool) -> CGFloat {
       switch style {
       case .regular:
           return SidebarConstants.regularWidth
       case .compact:
           return isAccessibility ? SidebarConstants.compactAccessibilityWidth : SidebarConstants.compactNormalWidth
       }
   }

}
