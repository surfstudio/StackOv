//
//  AnswerEntry.swift
//  StackOv (DataTransferObjects module)
//
//  Created by Erik Basargin
//  Copyright © 2021 Erik Basargin. All rights reserved.
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
        case comments
        case lastEditDate = "last_edit_date"
    }
    
    // MARK: - Public properties
    
    public let id: Int
    public let questionId: Int
    public let isAccepted: Bool
    public let score: Int
    public let link: URL?
    public let body: String?
    public let owner: ShallowUserEntry
    public let comments: [CommentEntry]?
    public let lastEditDate: Date?
}
