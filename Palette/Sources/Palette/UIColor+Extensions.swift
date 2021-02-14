//
//  UIColor+Extensions.swift
//  StackOv (Palette module)
//
//  Created by Erik Basargin
//  Copyright © 2021 Erik Basargin. All rights reserved.
//

#if canImport(AppKit) && !targetEnvironment(macCatalyst)
import AppKit.NSColor
#else
import UIKit.UIColor
#endif

#if canImport(UIKit)

public extension UIColor {
    
    typealias RGBAComponents = (red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat)
    
    var rgba: RGBAComponents {
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0

        getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        
        return (red, green, blue, alpha)
    }
    
    func image(_ size: CGSize = CGSize(width: 1, height: 1)) -> UIImage {
        UIGraphicsImageRenderer(size: size).image { rendererContext in
            setFill()
            rendererContext.fill(CGRect(origin: .zero, size: size))
        }
    }
    
    /// http://marcodiiga.github.io/rgba-to-rgb-conversion
    func rgbaToRgb(by backgroundColor: UIColor) -> UIColor {
        let currentComponents = self.rgba
        let backgroundComponents = backgroundColor.rgba

        let alpha = currentComponents.alpha
        let delta = 1 - alpha
        return UIColor(
            red: delta * backgroundComponents.red + alpha * currentComponents.red,
            green: delta * backgroundComponents.green + alpha * currentComponents.green,
            blue: delta * backgroundComponents.blue + alpha * currentComponents.blue,
            alpha: 1
        )
    }
}

#endif
