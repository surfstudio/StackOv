//
//  LoadAnswersRequests.swift
//  This source file is part of the StackOv open source project
//

import Network
import DataTransferObjects

public extension Request where Endpoint == StackexchangeNetworkService.LoadAnswers, Output == PostsEntry<AnswerEntry> {
    
    func callAsFunction(questionId id: Int, page: Int, pageSize: Int) -> Response {
        let systemParameters: [String: String] = [
            "key": StackexchangeNetworkService.Constants.quotaKey,
            "filter": StackexchangeNetworkService.Constants.answerFilter,
            "site": "stackoverflow"
        ]
        return process(
            parameters: systemParameters,
            encoder: NetworkParameterEncoder(destination: .queryString),
            arguments: id, page, pageSize
        )
    }
}
