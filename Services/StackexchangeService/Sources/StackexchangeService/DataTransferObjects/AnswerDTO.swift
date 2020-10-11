//
//  AnswerDTO.swift
//  
//
//  Created by Erik Basargin on 10/10/2020.
//

import Foundation

public typealias AnswerId = Int

public struct AnswerDTO: Codable {
    
    enum CodingKeys: String, CodingKey {
        case id = "answer_id"
        case questionId = "question_id"
        case isAccepted = "is_accepted"
        case score
        case link
        case body = "body_markdown"
        case owner
    }
    
    let id: AnswerId
    let questionId: QuestionId
    let isAccepted: Bool
    let score: Int
    let link: URL
    let body: String?
    let owner: UserDTO
}
