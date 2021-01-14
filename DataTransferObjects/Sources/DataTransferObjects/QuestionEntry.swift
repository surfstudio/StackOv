//
//  QuestionEntry.swift
//  This source file is part of the StackOv open source project
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
    public let owner: UserEntry?
    public let acceptedAnswerId: Int?
}

