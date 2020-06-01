//
//  QuestionItemModel.swift
//  StackOv
//
//  Created by Erik Basargin on 05/05/2020.
//  Copyright © 2020 Ephedra Software. All rights reserved.
//

import Foundation

struct QuestionItemModel: Identifiable {
    let id: QuestionId
    let title: String
    let isAnswered: Bool
    let viewCount: Int
    let answerCount: Int
    let score: Int
    let tags: [TagModel]
    let link: URL
}

extension QuestionItemModel {
    static func from(dto: QuestionDTO) -> QuestionItemModel {
        QuestionItemModel(
            id: dto.id,
            title: String(htmlString: dto.title) ?? dto.title,
            isAnswered: dto.acceptedAnswerId != nil,
            viewCount: dto.viewCount,
            answerCount: dto.answerCount,
            score: dto.score,
            tags: dto.tags.map { TagModel(name: $0) },
            link: dto.link
        )
    }
}
