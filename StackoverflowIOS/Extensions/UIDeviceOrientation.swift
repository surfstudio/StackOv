//
//  UIDeviceOrientation.swift
//  StackoverflowIOS
//
//  Created by Erik Basargin on 07/05/2020.
//  Copyright © 2020 Ephedra Software. All rights reserved.
//

import UIKit.UIDevice

extension UIDeviceOrientation {
    /// A Boolean value indicating whether the specified orientation is landscape right or landscape left.
    var isLandscape: Bool {
        switch self {
        case .landscapeRight, .landscapeLeft:
            return true
        default:
            return false
        }
    }
}
