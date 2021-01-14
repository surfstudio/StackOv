//
//  QuestionItemModel.swift
//  This source file is part of the StackOv open source project
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
