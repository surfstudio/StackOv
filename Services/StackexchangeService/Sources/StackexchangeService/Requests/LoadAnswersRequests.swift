//
//  LoadAnswersRequests.swift
//  
//
//  Created by Erik Basargin on 11/10/2020.
//

import Network

public extension Request where Endpoint == StackexchangeService.LoadAnswers, Output == PostsDTO<AnswerDTO> {
    
    func callAsFunction(questionId: QuestionId, page: Int, pageSize: Int) -> Response {
        let systemParameters: [String: String] = [
            "key": StackexchangeService.Constants.quotaKey,
            "filter": StackexchangeService.Constants.answerFilter,
            "size": "stackoverflow"
        ]
        return process(
            parameters: systemParameters,
            encoder: NetworkParameterEncoder(destination: .queryString),
            arguments: questionId, page, pageSize
        )
    }
}
