//
//  SearchQuestionsRequests.swift
//  
//
//  Created by Erik Basargin on 11/10/2020.
//

import Network

public extension Request where Endpoint == StackexchangeService.SearchQuestions, Output == PostsDTO<QuestionDTO> {
    
    func callAsFunction(query: String, page: Int, pageSize: Int) -> Response {
        let systemParameters: [String: String] = [
            "key": StackexchangeService.Constants.quotaKey,
            "filter": StackexchangeService.Constants.questionFilter,
            "size": "stackoverflow"
        ]
        return process(
            parameters: systemParameters,
            encoder: NetworkParameterEncoder(destination: .queryString),
            arguments: query, page, pageSize
        )
    }
}
