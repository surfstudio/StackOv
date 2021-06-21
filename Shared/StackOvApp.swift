//
//  StackOvApp.swift
//  StackOv
//
//  Created by Erik Basargin
//  Copyright © 2021 Erik Basargin. All rights reserved.
//

import SwiftUI
import MainFlow
#if canImport(Firebase)
import Firebase
#endif

@main
struct StackOvApp: App {

    var body: some Scene {
        #if canImport(Firebase)
        FirebaseApp.configure()
        #endif
        
        return WindowGroup {
            GeometryReader { geometry in
                MainFlow()
                    .environment(\.windowSize, geometry.size)
            }
        }
    }
}
