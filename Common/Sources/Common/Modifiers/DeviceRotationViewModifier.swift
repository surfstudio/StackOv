//
//  DeviceRotationViewModifier.swift
//  StackOv (Common module)
//
//  Created by Владислав Климов
//  Copyright © 2021 Erik Basargin. All rights reserved.
//

import SwiftUI

struct DeviceRotationViewModifier: ViewModifier {
    
    // MARK: - Properties
    
    let action: (UIDeviceOrientation) -> Void
    let orientationChanged = NotificationCenter.default.publisher(for: UIDevice.orientationDidChangeNotification)
            .makeConnectable()
            .autoconnect()
    
    // MARK: - Views
    
    func body(content: Content) -> some View {
        content
            .onAppear()
            .onReceive(orientationChanged) { _ in
                action(UIDevice.current.orientation)
            }
    }
    
}

// MARK: - View extension

public extension View {

    func onRotate(perform action: @escaping (UIDeviceOrientation) -> Void) -> some View {
        self.modifier(DeviceRotationViewModifier(action: action))
    }

}
