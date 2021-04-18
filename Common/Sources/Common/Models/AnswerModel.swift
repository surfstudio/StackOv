//
//  AnswerModel.swift
//  StackOv (Common module)
//
//  Created by Влад Климов
//  Copyright © 2021 Erik Basargin. All rights reserved.
//

import Foundation
import struct DataTransferObjects.AnswerEntry

public struct AnswerModel: Identifiable, Equatable {
    
    // MARK: - Properties
    
    public let id: Int
    public let questionId: Int
    public let isAccepted: Bool
    public let score: Int
    public let link: URL?
    public let body: String?
}

// MARK: - Equatable

public extension AnswerModel {
    
    static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.id == rhs.id
    }
}

// MARK: - Entry converter

public extension AnswerModel {

    static func from(entry: AnswerEntry) -> AnswerModel {
        AnswerModel(id: entry.id,
                    questionId: entry.questionId,
                    isAccepted: entry.isAccepted,
                    score: entry.score,
                    link: entry.link,
                    body: entry.body)
    }
}
