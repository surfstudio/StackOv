//
//  LoadQuestionRequests.swift
//  This source file is part of the StackOv open source project
//

import Network
import DataTransferObjects

public extension Request where Endpoint == StackexchangeNetworkService.LoadQuestion, Output == PostsEntry<QuestionEntry> {
    
    func callAsFunction(questionId id: Int) -> Response {
        let systemParameters: [String: String] = [
            "key": StackexchangeNetworkService.Constants.quotaKey,
            "filter": StackexchangeNetworkService.Constants.questionsFilter,
            "site": "stackoverflow"
        ]
        return process(
            parameters: systemParameters,
            encoder: NetworkParameterEncoder(destination: .queryString),
            arguments: id
        )
    }
}
