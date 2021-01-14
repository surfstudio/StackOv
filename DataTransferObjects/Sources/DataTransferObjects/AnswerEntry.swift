//
//  AnswerEntry.swift
//  This source file is part of the StackOv open source project
//

import Foundation

public struct AnswerEntry: Codable {
    
    // MARK: - Nested types
    
    public enum CodingKeys: String, CodingKey {
        case id = "answer_id"
        case questionId = "question_id"
        case isAccepted = "is_accepted"
        case score
        case link
        case body = "body_markdown"
        case owner
    }
    
    // MARK: - Public properties
    
    public let id: Int
    public let questionId: Int
    public let isAccepted: Bool
    public let score: Int
    public let link: URL
    public let body: String?
    public let owner: UserEntry
}
