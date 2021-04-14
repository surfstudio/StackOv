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
    
    // MARK: - Nested Types
    
    public enum AutoHide {
        case active(after: Double)
        case inactive
    }
    
    // MARK: - Properties
    
    public let id: UUID
    public let title: String
    public let description: String?
    public let style: NotificationBannerStyle
    public let autoHide: AutoHide
    
    // MARK: - Initialization
    
    public init(title: String, description: String? = nil, style: NotificationBannerStyle, autoHide: AutoHide = .active(after: 3)) {
        self.id = UUID()
        self.title = title
        self.description = description
        self.style = style
        self.autoHide = autoHide
    }

}
