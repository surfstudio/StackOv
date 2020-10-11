//
//  SidebarView.swift
//  StackOv (iOS)
//
//  Created by Erik Basargin on 06/10/2020.
//

import SwiftUI
import Palette

struct SidebarView: View {
    
    @Binding var state: MainBarItemType
    
    init(state: Binding<MainBarItemType>) {
        self._state = state
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: .zero) {
            ForEach(MainBarItemType.allCases) { item in
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
