//
//  LoadAnswerRequests.swift
//  This source file is part of the StackOv open source project
//

import Network

public extension Request where Endpoint == StackexchangeService.LoadAnswer, Output == PostsDTO<AnswerDTO> {
    
    func callAsFunction(id: AnswerId) -> Response {
        let systemParameters: [String: String] = [
            "key": StackexchangeService.Constants.quotaKey,
            "filter": StackexchangeService.Constants.answerFilter,
            "size": "stackoverflow"
        ]
        return process(
            parameters: systemParameters,
            encoder: NetworkParameterEncoder(destination: .queryString),
            arguments: id
        )
    }
}
