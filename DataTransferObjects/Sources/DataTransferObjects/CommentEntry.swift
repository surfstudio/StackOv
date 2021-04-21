//
//  PostsEntry.swift
//  StackOv (DataTransferObjects module)
//
//  Created by Владислав Климов
//  Copyright © 2021 Erik Basargin. All rights reserved.
//

import Foundation

public struct CommentEntry: Codable {
    
    // MARK: - Nested Types
    
    public enum CodingKeys: String, CodingKey {
        case body
        case bodyMarkdown = "body_markdown"
        case commentId = "comment_id"
        case creationDate = "creation_date"
        case edited
        case link
        case owner
        case postId = "post_id"
        case postType = "post_type"
        case replyToUser = "reply_to_user"
        case score
        case upvoted
    }
    
    // MARK: - Public Properties
    
    public let body: String?
    public let bodyMarkdown: String?
    public let commentId: Int
    public let creationDate: Date
    public let edited: Bool
    public let link: String?
    public let owner: ShallowUserEntry?
    public let postId: Int
    public let postType: String?
    public let replyToUser: ShallowUserEntry?
    public let score: Int?
    public let upvoted: Bool?
    
}
