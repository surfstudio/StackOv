//
//  SidebarView.swift
//  StackOv (MainFlow module)
//
//  Created by Erik Basargin
//  Copyright © 2021 Erik Basargin. All rights reserved.
//

import SwiftUI
import Palette
import AppScript

struct SidebarView: View {
    
    // MARK: - States

    @Binding var state: MainBar.ItemType
    @Store private var store: SidebarStore
    
    // MARK: - View
    
    var body: some View {
        switch store.sidebarStyle {
        case .regular:
            SidebarContentView(state: $state)
                .padding(EdgeInsets(top: 20, leading: 10, bottom: 20, trailing: 10))
                .background(Color.backgound)
                .frame(maxWidth: 210)
                .ignoresSafeArea(.container, edges: .top)
        case .compact:
            EmptyView()
        }
    }
}

// MARK: - Previews

struct SidebarView_Previews: PreviewProvider {
    
    static var previews: some View {
        SidebarView(state: .constant(.home))
    }
}

// MARK: - Colors

fileprivate extension Color {
    
    static let backgound = Palette.periwinkleCrayola | Palette.grayblue
}
