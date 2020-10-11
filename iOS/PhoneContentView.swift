//
//  PhoneContentView.swift
//  StackOv (iOS)
//
//  Created by Erik Basargin on 07/10/2020.
//

import SwiftUI
import Palette

import HomeFlow
import FavoriteFlow
import MessagesFlow
import TagsFlow
import UsersFlow

struct PhoneContentView: View {

    var body: some View {
        TabView {
            HomeFlow()
                .modifier(TabModifier(item: .home))
            
            FavoriteFlow()
                .modifier(TabModifier(item: .favorite))
            
            MessagesFlow()
                .modifier(TabModifier(item: .messages))
            
            TagsFlow()
                .modifier(TabModifier(item: .tags))
            
            UsersFlow()
                .modifier(TabModifier(item: .users))
        }
        .accentColor(Palette.white)
        .introspectTabBarController {
            $0.tabBar.barTintColor = PaletteCore.grayblue
        }
    }
}

// MARK: - Previews

struct PhoneContentView_Previews: PreviewProvider {
    
    static var previews: some View {
        PhoneContentView()
    }
}

// MARK: - View Modifiers

fileprivate struct TabModifier: ViewModifier {
    
    let item: MainBarItemType
    
    func body(content: Content) -> some View {
        content.tabItem {
            Image(systemName: item.image)
            Text(item.title)
        }.tag(item)
    }
}
