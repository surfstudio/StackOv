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
    case empty
    
    var backgroundColor: Color {
        switch self {
        case .info:
            return Palette.bluishwhite | Palette.grayblue
        case .success:
            return Palette.main
        case .error:
            return Palette.red
        case .empty:
            return .clear
        }
    }
    
    var buttonColor: Color {
        switch self {
        case .info:
            return Palette.gray | Palette.dullGray
        case .success:
            return Color.white.opacity(0.7)
        case .error:
            return Color.white.opacity(0.7)
        case .empty:
            return .clear
        }
    }
    
    var iconColor: Color {
        switch self {
        case .success, .error, .empty:
            return backgroundColor
        case .info:
            return Palette.steelGray300 | backgroundColor
        }
    }
    
    var textColor: Color {
        switch self {
        case .info:
            return Palette.black | .white
        case .error, .success:
            return .white
        case .empty:
            return .clear
        }
    }
    
}
