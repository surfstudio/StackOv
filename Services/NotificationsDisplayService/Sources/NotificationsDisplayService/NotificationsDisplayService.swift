//
//  NotificationsDisplayService.swift
//  StackOv (NotificationsDisplayService module)
//
//  Created by Владислав Климов
//  Copyright © 2021 Erik Basargin. All rights reserved.
//

import SwiftUI
import Components

public class NotificationsDisplayService: ObservableObject {
    
    // MARK: - Static Properties
    
    private static var uniqueInstance: NotificationsDisplayService?
    public static var shared: NotificationsDisplayService = {
        if uniqueInstance == nil {
            uniqueInstance = NotificationsDisplayService()
        }
        return uniqueInstance!
    }()
    
    // MARK: - Public Properties
    
    @Published public var notificationBannerData: NotificationBannerData = NotificationBannerData.emptyData()
    @Published public var isShow = false
    
    // MARK: - Initialization
    
    private init() {}

    // MARK: - Public Methods
    
    public func showNotification(data: NotificationBannerData) {
        self.notificationBannerData = data
        self.isShow = true
    }

}
