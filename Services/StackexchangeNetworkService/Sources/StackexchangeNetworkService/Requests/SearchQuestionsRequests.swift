//
//  SearchQuestionsRequests.swift
//  This source file is part of the StackOv open source project
//

import Network
import DataTransferObjects

public extension Request where Endpoint == StackexchangeNetworkService.SearchQuestions, Output == PostsEntry<QuestionEntry> {
    
    func callAsFunction(query: String, page: Int, pageSize: Int) -> Response {
        let systemParameters: [String: String] = [
            "key": StackexchangeNetworkService.Constants.quotaKey,
            "filter": StackexchangeNetworkService.Constants.questionFilter,
            "site": "stackoverflow"
        ]
        return process(
            parameters: systemParameters,
            encoder: NetworkParameterEncoder(destination: .queryString),
            arguments: query, page, pageSize
        )
    }
}
