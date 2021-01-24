//
//  QuestionItemModel.swift
//  StackOv (PageStore module)
//
//  Created by Erik Basargin
//  Copyright © 2021 Erik Basargin. All rights reserved.
//


import Foundation
import Common
import struct DataTransferObjects.QuestionEntry

public struct QuestionItemModel: Identifiable {
    
    public let id: Int
    public let title: String
    public let hasAcceptedAnswer: Bool
    public let viewCount: Int
    public let answerCount: Int
    public let score: Int
    public let tags: [String]
    public let link: URL
}

// MARK: - Entry converter

extension QuestionItemModel {
    
    static func from(entry: QuestionEntry) -> QuestionItemModel {
        QuestionItemModel(
            id: entry.id,
            title: String(htmlString: entry.title) ?? entry.title,
            hasAcceptedAnswer: entry.acceptedAnswerId != nil,
            viewCount: entry.viewCount,
            answerCount: entry.answerCount,
            score: entry.score,
            tags: entry.tags,
            link: entry.link
        )
    }
}
