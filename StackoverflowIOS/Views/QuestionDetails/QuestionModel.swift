//
//  QuestionModel.swift
//  StackoverflowIOS
//
//  Created by Erik Basargin on 16/05/2020.
//  Copyright © 2020 Ephedra Software. All rights reserved.
//

import Foundation

struct QuestionModel: Identifiable {
    let id: QuestionId
    let title: String
    let isAnswered: Bool
    let viewCount: Int
    let answerCount: Int
    let score: Int
    let tags: [TagModel]
    let link: URL
    let body: String
    let acceptedAnswerId: AnswerId?
}

extension QuestionModel {
    static func from(dto: QuestionDTO) -> QuestionModel {
        QuestionModel(
            id: dto.id,
            title: String(htmlString: dto.title) ?? dto.title,
            isAnswered: dto.isAnswered,
            viewCount: dto.viewCount,
            answerCount: dto.answerCount,
            score: dto.score,
            tags: dto.tags.map { TagModel(name: $0) },
            link: dto.link,
            body: dto.body ?? "",
            acceptedAnswerId: dto.acceptedAnswerId
        )
    }
}

