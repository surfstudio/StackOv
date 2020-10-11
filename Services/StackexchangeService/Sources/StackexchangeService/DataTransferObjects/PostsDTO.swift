//
//  PostsDTO.swift
//  
//
//  Created by Erik Basargin on 10/10/2020.
//

import Foundation

public struct PostsDTO<Item: Codable>: Codable {
    
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
