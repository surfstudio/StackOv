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
    @State var height: CGFloat = 0

    // MARK: - Views
    
    public func body(content: Content) -> some View {
        ZStack {
            content
            
            if !store.notifications.isEmpty {
                notificationList
                    .animation(.easeInOut)
                    .transition(AnyTransition.move(edge: .top).combined(with: .opacity))
            }
        }
    }
    
    // MARK: - View
    
    @ViewBuilder
    var notificationList: some View {
        if let model = store.notifications.last {
            if UIDevice.current.userInterfaceIdiom.isPhone {
                phoneNotificationList(model)
            } else {
                padNotificationList(store.notifications.reversed())
            }
        }
    }
    
    // MARK: - View Methods
    
    func phoneNotificationList(_ model: GlobalBanner.Model) -> some View {
        NotificationBannerView(model: .constant(model), action: closeAllBanners)
            .onAppear {
                if model.isAutoHidden {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                        closeAllBanners()
                    }
                }
            }
    }
    
    func padNotificationList(_ models: [GlobalBanner.Model]) -> some View {
        HStack(alignment: .top) {
            Spacer()
            VStack {
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 0) {
                        ForEach(models) { model in
                            NotificationBannerView(model: .constant(model), action: closeBunner)
                                .frame(width: 393)
                                .padding(EdgeInsets.horizontal(12))
                                .background(HeightPreferenceKeyReader())
                                .onAppear {
                                    if !model.isAutoHidden {
                                        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                                            closeAllBanners()
                                        }
                                    }
                                }
                        }
                        .padding(.top, 12)
                        Spacer()
                    }
                }
                .frame(height: height)
                .padding(0)
                Spacer()
            }
            .onPreferenceChange(HeightPreferenceKey.self) { height = $0 + CGFloat(store.notifications.count) * 8 + 12 }
        }
    }
    
    // MARK: - Private Methods
    
    private func closeAllBanners() {
        withAnimation {
            store.hideAllBanners()
        }
    }
    
    private func closeBunner(with id: UUID) {
        withAnimation {
            store.hideBanner(with: id)
        }
    }
    
}

// MARK: - Extensions

public extension View {
    
    func globalBanner() -> some View {
        modifier(GlobalBannerModifier())
    }
}

// MARK: - Fileprivate Preference Keys

fileprivate struct HeightPreferenceKey: PreferenceKey {
    static var defaultValue: CGFloat = 0

    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = value + nextValue()
    }
}

// MARK: - Fileprivate Views

fileprivate struct HeightPreferenceKeyReader: View {
    var body: some View {
        GeometryReader { geometryProxy in
            Color.clear.preference(key: HeightPreferenceKey.self, value: geometryProxy.size.height)
        }
    }
}
