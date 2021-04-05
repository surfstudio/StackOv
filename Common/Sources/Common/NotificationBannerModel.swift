//
//  NotificationBannerModel.swift
//  StackOv (Common module)
//
//  Created by Владислав Климов
//  Copyright © 2021 Erik Basargin. All rights reserved.
//

import SwiftUI

public enum NotificationBannerStyle {
    case info
    case success
    case error
}

public struct NotificationBannerModel {
    
    // MARK: - Properties
    
    public let title: String
    public let description: String?
    public let style: NotificationBannerStyle
    
    // MARK: - Initialization
    
    public init(title: String, description: String? = nil, style: NotificationBannerStyle) {
        self.title = title
        self.description = description
        self.style = style
    }
}
