//
//  RegularSidebarView.swift
//  StackOv (MainFlow module)
//
//  Created by Erik Basargin
//  Copyright © 2021 Erik Basargin. All rights reserved.
//

import SwiftUI
import Palette

struct RegularSidebarView: View {
    
    // MARK: - States
    
    @Binding var state: MainBar.ItemType
    
    // MARK: - Initialization
    
    init(state: Binding<MainBar.ItemType>) {
        self._state = state
    }
    
    // MARK: - View
    
    var body: some View {
        VStack(alignment: .leading, spacing: .zero) {
            ForEach(MainBar.ItemType.allCases) { item in
                RegularSidebarButton(item, state: $state)
            }

            Spacer()

            RegularUserView()
                .padding(EdgeInsets.leading(10))
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

struct RegularSidebarView_Previews: PreviewProvider {
    
    static var previews: some View {
        RegularSidebarView(state: .constant(.home))
            .padding(EdgeInsets(top: 20, leading: 10, bottom: 20, trailing: 10))
            .background(Palette.grayblue)
    }
}
