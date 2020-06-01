//
//  QuestionDTO.swift
//  StackOv
//
//  Created by Erik Basargin on 04/05/2020.
//  Copyright © 2020 Ephedra Software. All rights reserved.
//

import Foundation

typealias QuestionId = Int

struct QuestionDTO: Codable {
    enum CodingKeys: String, CodingKey {
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
    
    let id: QuestionId
    let title: String
    let isAnswered: Bool
    let viewCount: Int
    let answerCount: Int
    let score: Int
    let tags: [String]
    let link: URL
    let body: String?
    let owner: UserDTO?
    let acceptedAnswerId: AnswerId?
}
