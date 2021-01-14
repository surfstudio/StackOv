//
//  LoadQuestionsRequests.swift
//  This source file is part of the StackOv open source project
//

import Network
import DataTransferObjects

public extension Request where Endpoint == StackexchangeNetworkService.LoadQuestions, Output == PostsEntry<QuestionEntry> {
    
    func callAsFunction(page: Int, pageSize: Int) -> Response {
        let systemParameters: [String: String] = [
            "key": StackexchangeNetworkService.Constants.quotaKey,
            "filter": StackexchangeNetworkService.Constants.questionsFilter,
            "site": "stackoverflow"
        ]
        return process(
            parameters: systemParameters,
            encoder: NetworkParameterEncoder(destination: .queryString),
            arguments: page, pageSize
        )
    }
}
