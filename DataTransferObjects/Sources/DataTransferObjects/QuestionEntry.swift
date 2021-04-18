//
//  QuestionEntry.swift
//  StackOv (DataTransferObjects module)
//
//  Created by Erik Basargin
//  Copyright © 2021 Erik Basargin. All rights reserved.
//

import Foundation

public struct QuestionEntry: Codable {
    
    // MARK: - Nested types
    
    public enum CodingKeys: String, CodingKey {
        case id = "question_id"
        case title
        case isAnswered = "is_answered"
        case viewCount = "view_count"
        case answerCount = "answer_count"
        case score
        case tags
        case link
        case body = "body_markdown"
        case owner
        case acceptedAnswerId = "accepted_answer_id"
        case creationDate = "creation_date"
        case lastActivityDate = "last_activity_date"
        case comments
    }
    
    // MARK: - Public properties
    
    public let id: Int
    public let title: String
    public let isAnswered: Bool
    public let viewCount: Int
    public let answerCount: Int
    public let score: Int
    public let tags: [String]
    public let link: URL
    public let body: String?
    public let owner: ShallowUserEntry?
    public let acceptedAnswerId: Int?
    public let creationDate: Date?
    public let lastActivityDate: Date?
    public let comments: [CommentEntry]?
}

