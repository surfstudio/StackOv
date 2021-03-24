//
//  NotificationsDisplayble.swift
//  StackOv (NotificationsDisplayService module)
//
//  Created by Влад Климов
//  Copyright © 2021 Erik Basargin. All rights reserved.
//

import Foundation
import Components

public protocol NotificationsDisplayble {
    func showNotification(data: NotificationBannerData)
}

public extension NotificationsDisplayble {
    
    func showNotification(data: NotificationBannerData) {
        NotificationsDisplayService.shared.showNotification(data: data)
    }
    
}
