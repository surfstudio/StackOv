//
//  SidebarStore.swift
//  StackOv (SidebarStore module)
//
//  Created by Владислав Климов
//  Copyright © 2021 Erik Basargin. All rights reserved.
//

import Foundation
import Common
import enum SwiftUI.UserInterfaceSizeClass

public final class SidebarStore: ObservableObject {
    
    // MARK: - Public properties
        
    @Published public private(set) var isShown: Bool = true
    @Published public private(set) var sidebarStyle: SidebarStyle = .regular
    
    // MARK: - Internal properties
    
    var canBeShown: Bool = true
                
    // MARK: - Initialization and deinitialization
    
    public init() {}
}

// MARK: - Actions

public extension SidebarStore {

    func update(sidebarStyle: SidebarStyle) {
        self.sidebarStyle = sidebarStyle
    }
    
    func update(with sizeClass:  UserInterfaceSizeClass?) {
        switch sizeClass {
        case .regular:
            isShown = canBeShown
        default:
            isShown = false
        }
    }
    
    func toggle() {
        canBeShown.toggle()
        isShown = canBeShown
    }
}
