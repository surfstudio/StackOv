//
//  QuestionDTO.swift
//  StackoverflowIOS
//
//  Created by Erik Basargin on 04/05/2020.
//  Copyright © 2020 Ephedra Software. All rights reserved.
//

import Foundation

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
    }
    
    let id: Int
    let title: String
    let isAnswered: Bool
    let viewCount: Int
    let answerCount: Int
    let score: Int
    let tags: [String]
    let link: URL
}
