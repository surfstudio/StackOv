//
//  AnswerModel.swift
//  StackOv (Common module)
//
//  Created by Влад Климов
//  Copyright © 2021 Erik Basargin. All rights reserved.
//

import Foundation
import struct DataTransferObjects.AnswerEntry

public struct AnswerModel: Identifiable, Hashable {
    
    // MARK: - Properties
    
    public let answerId: Int
    public let questionId: Int
    public let isAccepted: Bool
    public let score: Int
    public let link: URL?
    public let body: String
    public let comments: [CommentModel]
    public let lastEditDate: Date?
    
    public var formattedVotesNumber: String {
        String.roundNumberWithAbbreviations(number: score)
    }
    
    public var formattedLastEditDate: String {
        formatDate(lastEditDate)
    }
    
}

// MARK: - Private Methods

private extension AnswerModel {

    func formatDate(_ date: Date?) -> String {
        guard let date = date else {
            return ""
        }
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM d, yyyy 'at' HH:mm"
        return formatter.string(from: date)
    }

}

// MARK: - Equatable

public extension AnswerModel {
    
    var id: Int { hashValue }
    
    static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(answerId)
    }
}

// MARK: - Entry converter

public extension AnswerModel {

    static func from(entry: AnswerEntry) -> AnswerModel {
        AnswerModel(answerId: entry.id,
                    questionId: entry.questionId,
                    isAccepted: entry.isAccepted,
                    score: entry.score,
                    link: entry.link,
                    body: entry.body,
                    comments: entry.comments?.compactMap { CommentModel.from(entry: $0) } ?? [],
                    lastEditDate: entry.lastEditDate)
    }

}

// MARK: - Mock

public extension AnswerModel {
    
    static func mock() -> AnswerModel {
        AnswerModel(answerId: 0,
                    questionId: 0,
                    isAccepted: true,
                    score: 10,
                    link: nil,
                    body: "Somebody once told me the world is gonna roll me I ain't the sharpest tool in the shed She was looking kind of dumb with her finger and her Thumb in the shape of an 'L' on her forehead Well the years start coming and they don't stop coming Fed to the rules and I hit the ground running Didn't make sense not to live for fun Your brain gets smart but your head gets dumb So much to do so much to see So what's wrong with taking the back streets You'll never know if you don't go You'll never shine if you don't glow",
                    comments: [],
                    lastEditDate: Date())
    }
    
}
