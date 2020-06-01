//
//  AnswerModel.swift
//  StackOv
//
//  Created by Erik Basargin on 23/05/2020.
//  Copyright © 2020 Ephedra Software. All rights reserved.
//

import Foundation

struct AnswerModel: Identifiable {
    let id: AnswerId
    let questionId: QuestionId
    let isAccepted: Bool
    let score: Int
    let link: URL
    let body: String
}

extension AnswerModel {
    static func from(dto: AnswerDTO) -> AnswerModel {
        AnswerModel(
            id: dto.id,
            questionId: dto.questionId,
            isAccepted: dto.isAccepted,
            score: dto.score,
            link: dto.link,
            body: dto.body ?? ""
        )
    }
}

