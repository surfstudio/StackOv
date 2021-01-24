//
//  StackOvApp.swift
//  StackOv
//
//  Created by Erik Basargin
//  Copyright © 2021 Erik Basargin. All rights reserved.
//

import SwiftUI
#if canImport(Firebase)
import Firebase
#endif

@main
struct StackOvApp: App {
    
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        #if canImport(Firebase)
        FirebaseApp.configure()
        #endif
        
        return WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
