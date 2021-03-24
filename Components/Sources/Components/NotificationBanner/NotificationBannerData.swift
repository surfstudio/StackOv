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
    internal let bunnerType: NotificationBannerType
    
    // MARK: - Initialization
    
    public init(title: String, description: String, bunnerType: NotificationBannerType) {
        self.title = title
        self.description = description
        self.bunnerType = bunnerType
    }
    
}

public extension NotificationBannerData {
    
    // MARK: - Public Methods
    
    static func emptyData() -> NotificationBannerData {
        NotificationBannerData(title: "", description: "", bunnerType: .empty)
    }
    
}
