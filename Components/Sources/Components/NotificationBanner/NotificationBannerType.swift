//
//  NotificationBannerType.swift
//  StackOv (Components module)
//
//  Created by Владислав Климов
//  Copyright © 2021 Erik Basargin. All rights reserved.
//

import SwiftUI
import Palette

public enum NotificationBannerType {
    case info
    case success
    case error
    
    var backgroundColor: Color {
        switch self {
        case .info:
            return Palette.bluishwhite | Palette.grayblue
        case .success:
            return Palette.main
        case .error:
            return .red
        }
    }
    
    var buttonColor: Color {
        switch self {
        case .info:
            return Palette.lightGray | Palette.dullGray
        case .success:
            return Color.white.opacity(0.7)
        case .error:
            return Color.white.opacity(0.7)
        }
    }
    
}
