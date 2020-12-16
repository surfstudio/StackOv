//
//  PostsDTO.swift
//  This source file is part of the StackOv open source project
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
