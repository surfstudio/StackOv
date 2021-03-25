//
//  NotificationsDisplayble.swift
//  StackOv (NotificationsDisplayService module)
//
//  Created by Влад Климов
//  Copyright © 2021 Erik Basargin. All rights reserved.
//

import Foundation
import Components
import Errors

public protocol NotificationsDisplayble {
    func showError(describedBy error: Error)    
    func showNotification(data: NotificationBannerData)
}

public extension NotificationsDisplayble {
    
    func showNotification(data: NotificationBannerData) {
        NotificationsDisplayService.shared.showNotification(data: data)
    }
    
    func showError(describedBy error: Error) {
        let errorMessage = BaseErrorHandler().handleError(error: error)
        showNotification(data: NotificationBannerData(title: "Error", description: errorMessage, bunnerType: .error))
    }
    
}
