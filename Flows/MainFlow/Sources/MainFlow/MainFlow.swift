//
//  MainFlow.swift
//  StackOv (MainFlow module)
//
//  Created by Erik Basargin
//  Copyright © 2021 Erik Basargin. All rights reserved.
//

import SwiftUI
import AppScript

public struct MainFlow: View {

    // MARK: - Initialization

    public init() {}
    
    // MARK: - View
    
    public var body: some View {
        if UIDevice.current.userInterfaceIdiom.isPhone {
            PhoneContentView()
                .globalBanner()
        } else {
            PadContentView()
                .globalBanner()
        }
    }
}
