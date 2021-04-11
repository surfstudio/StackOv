//
//  SidebarLeftButton.swift
//  StackOv (Components module)
//
//  Created by Erik Basargin
//  Copyright © 2021 Erik Basargin. All rights reserved.
//

import SwiftUI
import AppScript

public struct SidebarLeftButton: View {
    
    // MARK: - States
    
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    @Store var store: SidebarStore
    
    // MARK: - Initialization
    
    public init() {}
    
    // MARK: - View
    
    public var body: some View {
        if horizontalSizeClass == .regular, store.sidebarStyle == .regular {
            Button(action: { withAnimation { store.toggle() } }) {
                Image(systemName: "sidebar.left")
            }
        }
    }
}
