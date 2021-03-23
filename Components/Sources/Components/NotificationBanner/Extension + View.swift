//
//  Extension + View.swift
//  StackOv (Components module)
//
//  Created by Владислав Климов
//  Copyright © 2021 Erik Basargin. All rights reserved.
//

import SwiftUI

public extension View {
    func banner(data: Binding<NotificationBannerData>, show: Binding<Bool>) -> some View {
        self.modifier(NotificationBannerModifier(show: show, bannerData: data))
    }
}
