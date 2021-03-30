//
//  SidebarView.swift
//  StackOv (MainFlow module)
//
//  Created by Владислав Климов
//  Copyright © 2021 Erik Basargin. All rights reserved.
//

import SwiftUI
import AppScript
import SidebarStore
import Palette
import AppScript

struct SidebarView: View {
    
    // MARK: - States

    @Binding var state: MainBar.ItemType
    @Store private var store: SidebarStore
    
    // MARK: - View
    
    // MARK: - Views
    
    var body: some View {
        switch store.sidebarStyle {
        case .regular:
            regularSidebar
        case .compact:
            compactSideBar
        }
    }
    
    var regularSidebar: some View {
        RegularSidebarView(state: $state)
            .padding(EdgeInsets(top: 20, leading: 10, bottom: 20, trailing: 10))
            .background(Color.Sidebar.backgound)
            .frame(maxWidth: SidebarConstants.sidebarWidth(isRegular: isRegular, isAccessibility: sizeCategory.isAccessibilityCategory))
            .ignoresSafeArea(.container, edges: .top)
    }
    
    var compactSideBar: some View {
        CompactSidebarView(state: $state)
            .padding(.vertical, 20)
            .background(Color.Sidebar.backgound)
            .frame(maxWidth: SidebarConstants.sidebarWidth(isRegular: isRegular, isAccessibility: sizeCategory.isAccessibilityCategory))
            .ignoresSafeArea(.container, edges: .top)
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
