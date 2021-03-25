//
//  View+Extension.swift
//  StackOv (Components module)
//
//  Created by Владислав Климов
//  Copyright © 2021 Erik Basargin. All rights reserved.
//

import SwiftUI

public extension View {
    func banner(show: Binding<Bool>, bannerData: Binding<NotificationBannerData>) -> some View {
        modifier(NotificationBannerModifier(show: show, bannerData: bannerData))
    }
}
