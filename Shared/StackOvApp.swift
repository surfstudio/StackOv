//
//  StackOvApp.swift
//  This source file is part of the StackOv open source project
//

import SwiftUI
import Firebase

@main
struct StackOvApp: App {
    
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        FirebaseApp.configure()
        
        return WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
