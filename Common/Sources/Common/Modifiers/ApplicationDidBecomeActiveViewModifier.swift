//
//  ApplicationDidBecomeActiveViewModifier.swift
//  StackOv (Common module)
//
//  Created by Владислав Климов
//  Copyright © 2021 Erik Basargin. All rights reserved.
//

import SwiftUI

struct ApplicationDidBecomeActiveViewModifier: ViewModifier {
    
    // MARK: - Properties
    
    let action: () -> Void
    let didBecomeVisibleNotification = NotificationCenter.default.publisher(for: UIApplication.didBecomeActiveNotification)
            .makeConnectable()
            .autoconnect()
    
    // MARK: - Views

    func body(content: Content) -> some View {
        content
            .onAppear()
            .onReceive(didBecomeVisibleNotification) { _ in
                action()
            }
    }
    
}

// MARK: - View extension

public extension View {

    func onDidBecomeActive(perform action: @escaping () -> Void) -> some View {
        self.modifier(ApplicationDidBecomeActiveViewModifier(action: action))
    }

}

