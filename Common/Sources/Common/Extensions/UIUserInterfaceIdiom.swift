//
//  UIUserInterfaceIdiom.swift
//  StackOv (Common module)
//
//  Created by Erik Basargin
//  Copyright © 2021 Erik Basargin. All rights reserved.
//

import UIKit.UIDevice

public extension UIUserInterfaceIdiom {
    
    var isPhone: Bool {
        self == .phone
    }
    
    var isPad: Bool {
        self == .pad
    }
    
    var isMacCatalyst: Bool {
        #if targetEnvironment(macCatalyst)
        return true
        #else
        return false
        #endif
    }
    
}
