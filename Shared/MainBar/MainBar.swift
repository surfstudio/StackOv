//
//  MainBar.swift
//  StackOv (iOS)
//
//  Created by Erik Basargin on 15/12/2020.
//

import SwiftUI

import HomeFlow
import FavoriteFlow
import MessagesFlow
import TagsFlow
import UsersFlow

enum MainBar {
    
    enum ItemType: Int, CaseIterable {
        case home
        case favorite
        case messages
        case tags
        case users
    }
    
    static var tabs: some View {
        ForEach(ItemType.items) { item in
            item.page.modifier(TabModifier(item: item))
        }
    }
}

// MARK: - Item type extensions

extension MainBar.ItemType: Identifiable {
    var id: Int { hashValue }
}

extension MainBar.ItemType {
    
    var title: String {
        switch self {
        case .home:
            return "Home"
        case .favorite:
            return "Favorite"
        case .messages:
            return "Messages"
        case .tags:
            return "Tags"
        case .users:
            return "Users"
        }
    }
    
    var image: String {
        switch self {
        case .home:
            return "globe"
        case .favorite:
            return "star.fill"
        case .messages:
            return "tray.fill"
        case .tags:
            return "tag.fill"
        case .users:
            return "person.2.fill"
        }
    }
    
    static var items: [Self] {
        #if DEBUG
        return allCases
        #else
        return [
            .home,
            .favorite,
            .users
        ]
        #endif
    }
    
    @ViewBuilder var page: some View {
        _page.modifier(TabModifier(item: self))
    }
    
    @ViewBuilder private var _page: some View {
        switch self {
        case .home:
            HomeFlow()
        case .favorite:
            FavoriteFlow()
        case .messages:
            MessagesFlow()
        case .tags:
            TagsFlow()
        case .users:
            UsersFlow()
        }
    }
}

// MARK: - View Modifiers

fileprivate struct TabModifier: ViewModifier {
    
    let item: MainBar.ItemType
    
    func body(content: Content) -> some View {
        content.tabItem {
            Image(systemName: item.image)
            Text(item.title)
        }.tag(item)
    }
}
