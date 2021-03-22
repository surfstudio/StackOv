//
//  [NAME].swift
//  StackOv ([NAME] module)
//
//  Created by Владислав Климов
//  Copyright © 2021 Erik Basargin. All rights reserved.
//

import SwiftUI

public struct NotificationBannerData {
    
    // MARK: - Properties
    
    internal let title: String
    internal let description: String
    internal let color: Color
    
    // MARK: - Initialization
    
    public init(title: String, description: String, color: Color) {
        self.title = title
        self.description = description
        self.color = color
    }
    
}
