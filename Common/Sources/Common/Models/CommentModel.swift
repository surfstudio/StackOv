//
//  CommentModel.swift
//  StackOv (Common module)
//
//  Created by Владислав Климов
//  Copyright © 2021 Erik Basargin. All rights reserved.
//

import Foundation
import struct DataTransferObjects.CommentEntry

public struct CommentModel {
    
    // MARK: - Nested Types
    
    public enum PostType: String {
        case question
        case answer
        case article
    }
    
    // MARK: - Public Methods
    
    public let body: String?
    public let bodyMarkdown: String?
    public let commentId: Int
    public let creationDate: Date
    public let edited: Bool
    public let link: String?
    public let owner: ShallowUserModel?
    public let postId: Int
    public let postType: PostType?
    public let replyToUser: ShallowUserModel?
    public let score: Int?
    public let upvoted: Bool?
    
    public var formattedCreationDate: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "d MMM, yyyy 'at' HH:mm"
        return formatter.string(from: creationDate)
    }
    
}

// MARK: - Entry converter

public extension CommentModel {
    
    static func from(entry: CommentEntry) -> CommentModel {
        var owner: ShallowUserModel?
        if let entryOwner = entry.owner {
            owner = ShallowUserModel.from(entry: entryOwner)
        }

        var replyToUser: ShallowUserModel?
        if let entryReplyToUser = entry.replyToUser {
            replyToUser = ShallowUserModel.from(entry: entryReplyToUser)
        }

        return CommentModel(body: entry.body,
                            bodyMarkdown: entry.bodyMarkdown,
                            commentId: entry.commentId,
                            creationDate: entry.creationDate,
                            edited: entry.edited,
                            link: entry.link,
                            owner: owner,
                            postId: entry.postId,
                            postType: PostType(rawValue: entry.postType ?? ""),
                            replyToUser: replyToUser,
                            score: entry.score,
                            upvoted: entry.upvoted)
    }
    
}
