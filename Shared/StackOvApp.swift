//
//  StackOvApp.swift
//  Shared
//
//  Created by Erik Basargin on 29/09/2020.
//

import SwiftUI

@main
struct StackOvApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
