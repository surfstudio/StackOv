//
//  SidebarContentView.swift
//  StackOv (MainFlow module)
//
//  Created by Erik Basargin
//  Copyright © 2021 Erik Basargin. All rights reserved.
//

import SwiftUI
import Palette

struct SidebarContentView: View {
    
    // MARK: - States
    
    @Binding var state: MainBar.ItemType

    // MARK: - View
    
    var body: some View {
        VStack(alignment: .leading, spacing: .zero) {
            ForEach(MainBar.ItemType.allCases) { item in
                SidebarButton(item, state: $state)
            }

            Spacer()

            UserView()
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

struct SidebarContentView_Previews: PreviewProvider {
    
    static var previews: some View {
        SidebarContentView(state: .constant(.home))
            .padding(EdgeInsets(top: 20, leading: 10, bottom: 20, trailing: 10))
            .background(Palette.grayblue)
    }
}
