//
//  PostsEntry.swift
//  This source file is part of the StackOv open source project
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
