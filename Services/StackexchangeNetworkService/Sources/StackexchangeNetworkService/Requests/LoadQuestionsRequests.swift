//
//  LoadQuestionsRequests.swift
//  StackOv (StackexchangeNetworkService module)
//
//  Created by Erik Basargin
//  Copyright © 2021 Erik Basargin. All rights reserved.
//

import Network
import Combine
import Foundation
import DataTransferObjects

public extension Request where Endpoint == StackexchangeNetworkService.LoadQuestions, Output == PostsEntry<QuestionEntry> {
    
    func callAsFunction(page: Int, pageSize: Int) -> AnyPublisher<Output, Error> {
        let systemParameters: [URLQueryItem] = [
            URLQueryItem(name: "key", value: StackexchangeNetworkService.Constants.quotaKey),
            URLQueryItem(name: "filter", value: StackexchangeNetworkService.Constants.questionsFilter),
            URLQueryItem(name: "site", value: "stackoverflow")
        ]
        
        do {
            let request = try buildURLRequest(parameters: systemParameters, arguments: [page, pageSize])
            return URLSession.shared.dataTaskPublisher(for: request)
                .tryCatchHTTPError()
                .map { $0.data }
                .decode(type: Output.self, decoder: produceJSONDecoder())
                .eraseToAnyPublisher()
        } catch {
            return Fail(error: error).eraseToAnyPublisher()
        }
    }
}
