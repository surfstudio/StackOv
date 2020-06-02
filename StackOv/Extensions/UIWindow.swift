//
//  UIWindow.swift
//  StackOv
//
//  Created by Erik Basargin on 02/06/2020.
//  Copyright © 2020 Ephedra Software. All rights reserved.
//

import UIKit

extension UIWindow {
    static var main: UIWindow? {
        UIApplication.shared.windows.first { $0.isKeyWindow }
    }
}
