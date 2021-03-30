//
//  SidebarStore.swift
//  StackOv (SidebarStore module)
//
//  Created by Владислав Климов
//  Copyright © 2021 Erik Basargin. All rights reserved.
//

import Foundation

public final class SidebarStore: ObservableObject {

    // MARK: - Public properties
        
    public private(set) var isShow: Bool = true
                
    // MARK: - Initialization
    
    public init() {}

}

// MARK: - Actions

public extension SidebarStore {
        
    func changeShow(_ isShow: Bool) {
        self.isShow = isShow
    }

}
