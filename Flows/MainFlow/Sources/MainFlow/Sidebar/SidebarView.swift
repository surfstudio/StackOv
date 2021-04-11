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
import Common

struct SidebarView: View {
    
    // MARK: - States

    @Environment(\.sizeCategory) var sizeCategory: ContentSizeCategory
    @Binding var state: MainBar.ItemType
    @Store private var store: SidebarStore
    
    // MARK: - View
    
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
            .background(Color.backgound)
            .frame(maxWidth: SidebarConstants.sidebarWidth(isRegular: true, isAccessibility: sizeCategory.isAccessibilityCategory))
            .ignoresSafeArea(.container, edges: .top)
    }
    
    var compactSideBar: some View {
        CompactSidebarView(state: $state)
            .padding(.vertical, 20)
            .background(Color.backgound)
            .frame(maxWidth: SidebarConstants.sidebarWidth(isRegular: false, isAccessibility: sizeCategory.isAccessibilityCategory))
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
