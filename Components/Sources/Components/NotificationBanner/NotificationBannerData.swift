//
//  NotificationBannerData.swift
//  StackOv (Components module)
//
//  Created by Владислав Климов
//  Copyright © 2021 Erik Basargin. All rights reserved.
//

import SwiftUI

public struct NotificationBannerData {
    
    // MARK: - Properties
    
    internal let title: String
    internal let description: String
    internal let backgroundColor: Color
    internal let buttonColor: Color
    
    // MARK: - Initialization
    
    public init(title: String, description: String, bunnerType: NotificationBannerType) {
        self.title = title
        self.description = description
        self.backgroundColor = bunnerType.backgroundColor
        self.buttonColor = bunnerType.buttonColor
    }
    
}

public extension NotificationBannerData {
    
    // MARK: - Public Methods
    
    static func emptyData() -> NotificationBannerData {
        NotificationBannerData(title: "", description: "", bunnerType: .empty)
    }
    
}
