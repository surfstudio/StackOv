//
//  MainFlow.swift
//  StackOv (MainFlow module)
//
//  Created by Erik Basargin
//  Copyright © 2021 Erik Basargin. All rights reserved.
//

import SwiftUI
import NotificationsDisplayService

public struct MainFlow: View {
    
    // MARK: - Properties
    
    @StateObject var notificationsDisplayService = NotificationsDisplayService.shared

    // MARK: - Initialization

    public init() {}
    
    // MARK: - View
    
    public var body: some View {
        if UIDevice.current.userInterfaceIdiom.isPhone {
            PhoneContentView()
                .banner(show: $notificationsDisplayService.isShow, bannerData: $notificationsDisplayService.notificationBannerData)
        } else {
            PadContentView()
                .banner(show: $notificationsDisplayService.isShow, bannerData: $notificationsDisplayService.notificationBannerData)
        }
    }
}
