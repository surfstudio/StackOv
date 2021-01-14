//
//  UIUserInterfaceIdiom.swift
//  This source file is part of the StackOv open source project
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
