//
//  PostsDTO.swift
//  StackOv
//
//  Created by Erik Basargin on 05/05/2020.
//  Copyright © 2020 Ephedra Software. All rights reserved.
//

import Foundation

struct PostsDTO<Item: Codable>: Codable {
    enum CodingKeys: String, CodingKey {
        case items
        case hasMore = "has_more"
        case quotaMax = "quota_max"
        case quotaRemaining = "quota_remaining"
    }
    
    let items: [Item]
    let hasMore: Bool
    let quotaMax: Int
    let quotaRemaining: Int
}
