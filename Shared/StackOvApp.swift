//
//  StackOvApp.swift
//  This source file is part of the StackOv open source project
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
