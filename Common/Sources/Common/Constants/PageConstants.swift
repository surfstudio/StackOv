//
//  PageConstrants.swift
//  StackOv (Common module)
//
//  Created by  Erik Basargin
//  Copyright © 2021 Erik Basargin. All rights reserved.
//

import Foundation
import UIKit.UIDevice
import struct UIKit.CGFloat

public enum PageConstrants {
    
    public static let gridItemMinimumWidth: CGFloat = 267
    public static let gridItemMaximumHeight: CGFloat = 223
    public static var defaultSpacing: CGFloat {
        UIDevice.current.userInterfaceIdiom.isPad ? 18 : 12
    }
}
