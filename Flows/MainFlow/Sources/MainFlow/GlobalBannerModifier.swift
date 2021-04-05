//
//  GlobalBannerModifier.swift
//  StackOv (MainFlow module)
//
//  Created by Владислав Климов
//  Copyright © 2021 Erik Basargin. All rights reserved.
//

import SwiftUI
import Common
import Components
import AppScript

public struct GlobalBannerModifier: ViewModifier {
    
    // MARK: - States
    
    @Store var store: GlobalBannerStore
    
    // MARK: - Views
    
    public func body(content: Content) -> some View {
        ZStack {
            content
            
            if !store.notifications.isEmpty {
                notificationList
                    .animation(.easeInOut)
                    .transition(AnyTransition.move(edge: .top).combined(with: .opacity))
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                            closeNotificationBanner()
                        }
                    }
            }
        }
    }
    
    // MARK: - View
    
    @ViewBuilder
    var notificationList: some View {
        if let model = store.notifications.last {
            if UIDevice.current.userInterfaceIdiom.isPhone {
                NotificationBannerView(model: .constant(model), action: closeNotificationBanner)
            } else {
                HStack {
                    Spacer()
                    NotificationBannerView(model: .constant(model), action: closeNotificationBanner)
                        .frame(width: 393)
                }
            }
        }
    }
    
    // MARK: - Private Methods
    
    private func closeNotificationBanner() {
        withAnimation {
            store.hideAllBanners()
        }
    }
}

// MARK: - Extensions

public extension View {
    
    func globalBanner() -> some View {
        modifier(GlobalBannerModifier())
    }
}
