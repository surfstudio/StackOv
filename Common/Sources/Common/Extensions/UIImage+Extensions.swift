//
//  UIImage+Extensions.swift
//  StackOv (Common module)
//
//  Created by  Erik Basargin
//  Copyright © 2021 Erik Basargin. All rights reserved.
//

import class UIKit.UIImage

extension UIImage: Identifiable {
    
    public var id: Int { hashValue }
}
