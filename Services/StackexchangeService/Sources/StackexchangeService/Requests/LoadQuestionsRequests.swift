//
//  LoadQuestionsRequests.swift
//  This source file is part of the StackOv open source project
//

import Network

public extension Request where Endpoint == StackexchangeService.LoadQuestions, Output == PostsDTO<QuestionDTO> {
    
    func callAsFunction(page: Int, pageSize: Int) -> Response {
        let systemParameters: [String: String] = [
            "key": StackexchangeService.Constants.quotaKey,
            "filter": StackexchangeService.Constants.questionsFilter,
            "size": "stackoverflow"
        ]
        return process(
            parameters: systemParameters,
            encoder: NetworkParameterEncoder(destination: .queryString),
            arguments: page, pageSize
        )
    }
}
