//
//  SidebarView.swift
//  StackOv
//
//  Created by Erik Basargin
//  Copyright © 2021 Erik Basargin. All rights reserved.
//

import SwiftUI
import Palette

struct SidebarView: View {
    
    @Binding var state: MainBar.ItemType
    
    init(state: Binding<MainBar.ItemType>) {
        self._state = state
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: .zero) {
            ForEach(MainBar.ItemType.allCases) { item in
                SidebarButton(item, state: $state)
            }
            
            Spacer()

            UserView()
                .padding(EdgeInsets.leading(10))
        }
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

struct SidebarView_Previews: PreviewProvider {
    
    static var previews: some View {
        SidebarView(state: .constant(.home))
            .padding(EdgeInsets(top: 20, leading: 10, bottom: 20, trailing: 10))
            .background(Palette.grayblue)
    }
}
