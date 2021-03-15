//
//  StackOvApp.swift
//  StackOv
//
//  Created by Erik Basargin
//  Copyright © 2021 Erik Basargin. All rights reserved.
//

import SwiftUI
import MainFlow
import AuthManager
#if canImport(Firebase)
import Firebase
#endif

@main
struct StackOvApp: App {

    @StateObject var authManager = AuthManager.appearance()

    var body: some Scene {
        #if canImport(Firebase)
        FirebaseApp.configure()
        #endif
        
        return WindowGroup {
            MainFlow()
        }
    }
}
