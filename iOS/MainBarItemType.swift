//
//  MainBarItemType.swift
//  StackOv (iOS)
//
//  Created by Erik Basargin on 06/10/2020.
//

import SwiftUI

enum MainBarItemType: Int, CaseIterable {

    case home
    case favorite
    case messages
    case tags
    case users
}

extension MainBarItemType: Identifiable {
    
    var id: Int { hashValue }
}

extension MainBarItemType {
    
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
}
