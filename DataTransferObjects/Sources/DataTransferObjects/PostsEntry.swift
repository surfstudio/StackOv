//
//  PostsEntry.swift
//  StackOv (DataTransferObjects module)
//
//  Created by Erik Basargin
//  Copyright © 2021 Erik Basargin. All rights reserved.
//


import Foundation

public struct PostsEntry<Item: Codable>: Codable {
    
    // MARK: - Nested types
    
    public enum CodingKeys: String, CodingKey {
        case items
        case hasMore = "has_more"
        case quotaMax = "quota_max"
        case quotaRemaining = "quota_remaining"
    }
    
    // MARK: - Public properties
    
    public let items: [Item]
    public let hasMore: Bool
    public let quotaMax: Int
    public let quotaRemaining: Int
}
