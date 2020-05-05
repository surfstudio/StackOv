//
//  QuestionItemModel.swift
//  StackoverflowIOS
//
//  Created by Erik Basargin on 05/05/2020.
//  Copyright © 2020 Ephedra Software. All rights reserved.
//

import Foundation

struct QuestionItemModel: Identifiable {
    let id: Int
    let title: String
    let isAnswered: Bool
    let viewCount: Int
    let answerCount: Int
    let score: Int
    let tags: [String]
    let link: URL
}

extension QuestionItemModel {
    static func from(dto: QuestionDTO) -> QuestionItemModel {
        QuestionItemModel(
            id: dto.id,
            title: String(htmlString: dto.title) ?? dto.title,
            isAnswered: dto.isAnswered,
            viewCount: dto.viewCount,
            answerCount: dto.answerCount,
            score: dto.score,
            tags: dto.tags,
            link: dto.link
        )
    }
}
