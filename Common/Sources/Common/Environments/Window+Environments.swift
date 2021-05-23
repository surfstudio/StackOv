//
//  WindowSize.swift
//  StackOv (Common module)
//
//  Created by Erik Basargin
//  Copyright © 2021 Erik Basargin. All rights reserved.
//

import SwiftUI

public extension EnvironmentValues {
    
    var windowSize: CGSize {
        get { self[WindowSizeKey.self] }
        set { self[WindowSizeKey.self] = newValue }
    }
}

// MARK: - Default values

private struct WindowSizeKey: EnvironmentKey {
    
    static var defaultValue: CGSize {
        UIApplication.shared.windows.filter { $0.isKeyWindow }.first!.frame.size
    }
}
