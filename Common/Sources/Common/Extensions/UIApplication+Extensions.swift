//
//  UIApplication+Extensions.swift
//  StackOv (Common module)
//
//  Created by Erik Basargin
//  Copyright © 2021 Erik Basargin. All rights reserved.
//

import Foundation
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

    func tryOpen(url: URL?, options: [UIApplication.OpenExternalURLOptionsKey : Any] = [:], completionHandler completion: ((Bool) -> Void)? = nil) {
        guard let url = url else {
            completion?(false)
            return
        }
        if canOpenURL(url) {
            open(url, options: options, completionHandler: completion)
        }
    }
}
