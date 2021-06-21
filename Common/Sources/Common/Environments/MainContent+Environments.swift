//
//  [NAME].swift
//  StackOv ([NAME] module)
//
//  Created by Владислав Климов
//  Copyright © 2021 Erik Basargin. All rights reserved.
//

import SwiftUI

public extension EnvironmentValues {
    
    var mainContentSize: CGSize {
        get { self[MainContentSizeKey.self] }
        set { self[MainContentSizeKey.self] = newValue }
    }
}

// MARK: - Default values

private struct MainContentSizeKey: EnvironmentKey {
    
    static var defaultValue: CGSize {
        UIApplication.shared.windows.filter { $0.isKeyWindow }.first!.frame.size
    }
}
