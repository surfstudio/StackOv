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

public struct NotificationBannerModel: Identifiable {
    
    // MARK: - Properties
    
    public let id: UUID
    public let title: String
    public let description: String?
    public let style: NotificationBannerStyle
    public let isAutoHidden: Bool
    
    // MARK: - Initialization
    
    public init(title: String, description: String? = nil, style: NotificationBannerStyle, isAutoHidden: Bool = true) {
        self.id = UUID()
        self.title = title
        self.description = description
        self.style = style
        self.isAutoHidden = isAutoHidden
    }

}
