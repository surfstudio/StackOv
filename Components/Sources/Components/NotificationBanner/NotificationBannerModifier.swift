//
//  NotificationBannerModifier.swift
//  StackOv (Components module)
//
//  Created by Владислав Климов
//  Copyright © 2021 Erik Basargin. All rights reserved.
//

import SwiftUI

public struct NotificationBannerModifier: ViewModifier {
    
    // MARK: - Properties
    
    @Binding var show: Bool
    @Binding var bannerData: NotificationBannerData
    
    // MARK: - Views
    
    public func body(content: Content) -> some View {
        ZStack {
            content
            if show {
                notificationView()
                    .animation(.easeInOut)
                    .transition(AnyTransition.move(edge: .top).combined(with: .opacity))
                    .onAppear(perform: {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 3, execute: {
                            closeNotificationBanner()
                        })
                    })
            }
        }
    }
    
    // MARK: - View Methods
    
    @ViewBuilder
    func notificationView() -> some View {
        if (UIDevice.current.userInterfaceIdiom.isPhone) {
            NotificationBannerView(data: $bannerData, action: closeNotificationBanner)
        } else {
            HStack {
                Spacer()
                NotificationBannerView(data: $bannerData, action: closeNotificationBanner)
                    .frame(width: 393)
            }
        }
    }
    
    // MARK: - Private Methods
    
    private func closeNotificationBanner() {
        withAnimation {
            self.show = false
        }
    }
    
}
