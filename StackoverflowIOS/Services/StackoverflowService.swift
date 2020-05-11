//
//  StackoverflowService.swift
//  StackoverflowIOS
//
//  Created by Erik Basargin on 04/05/2020.
//  Copyright © 2020 Ephedra Software. All rights reserved.
//

import Foundation
import RService
import Combine

final class StackoverflowService: HTTPServiceProtocol {
    // MARK: - Nested types
    
    enum Constants {
        static let baseUrl = URL(string: "https://api.stackexchange.com/2.2")!
        static let questionsFilter = "!iCFKZYSfKkDllaaViW.sv)"
    }
    
    // MARK: - Endpoints
    
    enum LoadQuestions {}
    enum SearchQuestions {}
    
    // MARK: - Requests
    
    @GET(Constants.baseUrl, "/questions?filter=\(Constants.questionsFilter)&site=stackoverflow&order=desc&sort=activity&page=%d&pagesize=%d")
    var loadQuestions: Request<LoadQuestions, PostsDTO<QuestionDTO>>
    
    @GET(Constants.baseUrl, "/search/advanced?filter=\(Constants.questionsFilter)&site=stackoverflow&order=desc&sort=activity&q=%@&page=%d&pagesize=%d")
    var searchQuestions: Request<SearchQuestions, PostsDTO<QuestionDTO>>
}

extension HTTP.Request where Endpoint == StackoverflowService.LoadQuestions, Output == PostsDTO<QuestionDTO> {
    func callAsFunction(page: Int, pageSize: Int) -> Response {
        guard let urlString = String(format: urlMask, page, pageSize).urlQueryAllowed else {
            return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
        }
        print("Loading: \(urlString)")
        return process(urlString)
    }
}

extension HTTP.Request where Endpoint == StackoverflowService.SearchQuestions, Output == PostsDTO<QuestionDTO> {
    func callAsFunction(query: String, page: Int, pageSize: Int) -> Response {
        guard let urlString = String(format: urlMask, query, page, pageSize).urlQueryAllowed else {
            return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
        }
        print("Search: \(urlString)")
        return process(urlString)
    }
}
