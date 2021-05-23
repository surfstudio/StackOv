//
//  ThreadFlowScreenConfiguration.swift
//  StackOv (ThreadFlow module)
//
//  Created by Владислав Климов
//  Copyright © 2021 Erik Basargin. All rights reserved.
//

import SwiftUI

enum ThreadFlowScreenConfiguration {
    
    static func horisontalInset(horizontalSizeClass: UserInterfaceSizeClass?) -> CGFloat {
        return UIDevice.current.userInterfaceIdiom.isPad && horizontalSizeClass == .regular ? 60 : 20
    }
    
    static func contentEdgeInsets(horizontalSizeClass: UserInterfaceSizeClass?) -> EdgeInsets {
        let vertical: CGFloat = UIDevice.current.userInterfaceIdiom.isPad ? 18 : 12
        let horisontal: CGFloat = horisontalInset(horizontalSizeClass: horizontalSizeClass)
        return EdgeInsets(top: vertical, leading: horisontal, bottom: vertical, trailing: horisontal)
    }
    
}
