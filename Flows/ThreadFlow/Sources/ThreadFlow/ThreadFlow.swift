//
//  ThreadFlow.swift
//  StackOv (ThreadFlow module)
//
//  Created by Владислав Климов
//  Copyright © 2021 Erik Basargin. All rights reserved.
//

import SwiftUI
import AppScript
import ThreadStore

public struct ThreadFlow: View {
    
    // MARK: - States
    
    @EnvironmentObject var store: ThreadStore
    
    // MARK: - Initialization
    
    public init() {}
    
    // MARK: - View
    
    public var body: some View {
        ThreadView()
            .environmentObject(store)
    }

}
