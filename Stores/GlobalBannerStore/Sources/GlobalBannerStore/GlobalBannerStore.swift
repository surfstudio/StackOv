//
//  GlobalBannerStore.swift
//  StackOv (GlobalBannerStore module)
//
//  Created by Erik Basargin
//  Copyright © 2021 Erik Basargin. All rights reserved.
//

import Foundation
import Common
import Components
import Combine
import protocol SwiftUI.View

public final class GlobalBannerStore: ObservableObject {
    
    // MARK: - Public properties
    
    @Published public private(set) var notifications: [GlobalBanner.Model] = []
    
    // MARK: - Internal properties
    
    private(set) var globalBannerSubscription: AnyCancellable!
    
    // MARK: - Initialization and deinitialization
    
    public init() {
        self.globalBannerSubscription = GlobalBanner.publisher
            .receive(on: RunLoop.main)
            .sink { [weak self] model in
                self?.notifications.append(model)
            }
    }
    
    // MARK: - Actions
    
    public func hideAllBanners() {
        notifications = []
    }
}
