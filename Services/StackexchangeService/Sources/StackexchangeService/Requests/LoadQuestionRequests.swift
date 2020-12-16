//
//  LoadQuestionRequests.swift
//  This source file is part of the StackOv open source project
//

import Network

public extension Request where Endpoint == StackexchangeService.LoadQuestion, Output == PostsDTO<QuestionDTO> {
    
    func callAsFunction(id: QuestionId) -> Response {
        let systemParameters: [String: String] = [
            "key": StackexchangeService.Constants.quotaKey,
            "filter": StackexchangeService.Constants.questionsFilter,
            "size": "stackoverflow"
        ]
        return process(
            parameters: systemParameters,
            encoder: NetworkParameterEncoder(destination: .queryString),
            arguments: id
        )
    }
}
