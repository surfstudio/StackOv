//
//  CompactSidebarView.swift
//  StackOv (MainFlow module)
//
//  Created by Владислав Климов
//  Copyright © 2021 Erik Basargin. All rights reserved.
//

import SwiftUI
import Palette

struct CompactSidebarView: View {
    
    // MARK: - States
    
    @Binding var state: MainBar.ItemType
    
    // MARK: - Initialization
    
    init(state: Binding<MainBar.ItemType>) {
        self._state = state
    }
    
    // MARK: - View
    
    var body: some View {
        VStack(alignment: .center, spacing: .zero) {
            ForEach(MainBar.ItemType.allCases) { item in
                CompactSidebarButton(item, state: $state)
            }
            
            Spacer()
            
            CompactUserView()
        }
        .padding(.top, 11)
        .frame(
            minWidth: 0,
            maxWidth: .infinity,
            minHeight: 0,
            maxHeight: .infinity,
            alignment: .topLeading
        )
    }
}

// MARK: - Previews

struct CompactSidebarView_Previews: PreviewProvider {
    
    static var previews: some View {
        CompactSidebarView(state: .constant(.home))
            .padding(EdgeInsets(top: 20, leading: 10, bottom: 20, trailing: 10))
            .background(Palette.grayblue)
    }
}
