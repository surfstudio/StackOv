//
//  UIApplication+Extensions.swift
//  StackOv (Common module)
//
//  Created by Erik Basargin
//  Copyright © 2021 Erik Basargin. All rights reserved.
//

import class UIKit.UIApplication
import struct CoreGraphics.CGFloat
import struct CoreGraphics.CGSize

public extension UIApplication {
    
    var keyWindowSize: CGSize {
        windows.filter { $0.isKeyWindow }.first?.frame.size ?? .zero
    }
    
    var statusBarHeight: CGFloat {
        windows.filter { $0.isKeyWindow }.first?.windowScene?.statusBarManager?.statusBarFrame.height ?? .zero
    }
}
