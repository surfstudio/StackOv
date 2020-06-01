//
//  UIUserInterfaceIdiom.swift
//  StackOv
//
//  Created by Erik Basargin on 07/05/2020.
//  Copyright © 2020 Ephedra Software. All rights reserved.
//

import UIKit.UIDevice

extension UIUserInterfaceIdiom {
    
    var isPhone: Bool {
        self == .phone
    }
    
    var isMac: Bool {
        #if targetEnvironment(macCatalyst)
        return true
        #else
        return false
        #endif
    }
    
}
