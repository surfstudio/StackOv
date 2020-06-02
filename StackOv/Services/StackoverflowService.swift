//
//  StackoverflowService.swift
//  StackOv
//
//  Created by Erik Basargin on 04/05/2020.
//  Copyright © 2020 Ephedra Software. All rights reserved.
//

import Foundation
import RService
import Combine

struct StackoverflowService: HTTPServiceProtocol {
    // MARK: - Nested types
    
    enum Constants {
        static let baseUrl = URL(string: "https://api.stackexchange.com/2.2")!
        static let questionsFilter = "!*7PZ(S77sKA3Rc8i4h4)QI0bM8HG"
        static let questionFilter = "!PvyfxTBzonJRcqwIa*BHYvqSvHDWMY"
        static let answerFilter = "!3xJkL2qoqNZw7Litv"
        static let quotaKey = "P8uUWwsGz2WbRs6)qHu)yw(("
    }
    
    // MARK: - Endpoints
    
    enum LoadQuestions {}
    enum SearchQuestions {}
    enum LoadQuestion {}
    enum LoadAnswer {}
    enum LoadAnswers {}
    
    // MARK: - Requests
    
    @GET(Constants.baseUrl, "/questions?key=\(Constants.quotaKey)&filter=\(Constants.questionsFilter)&site=stackoverflow&order=desc&sort=votes&page=%d&pagesize=%d")
    var loadQuestions: Request<LoadQuestions, PostsDTO<QuestionDTO>>
    
    @GET(Constants.baseUrl, "/search/advanced?key=\(Constants.quotaKey)&filter=\(Constants.questionsFilter)&site=stackoverflow&order=desc&sort=votes&q=%@&page=%d&pagesize=%d")
    var searchQuestions: Request<SearchQuestions, PostsDTO<QuestionDTO>>
    
    @GET(Constants.baseUrl, "/questions/%d?key=\(Constants.quotaKey)&filter=\(Constants.questionFilter)&site=stackoverflow")
    var loadQuestion: Request<LoadQuestion, PostsDTO<QuestionDTO>>
    
    @GET(Constants.baseUrl, "/answers/%d?key=\(Constants.quotaKey)&filter=\(Constants.answerFilter)&site=stackoverflow")
    var loadAnswer: Request<LoadAnswer, PostsDTO<AnswerDTO>>
    
    @GET(Constants.baseUrl, "/questions/%d/answers?key=\(Constants.quotaKey)&filter=\(Constants.answerFilter)&site=stackoverflow&order=desc&sort=votes&page=%d&pagesize=%d")
    var loadAnswers: Request<LoadAnswers, PostsDTO<AnswerDTO>>
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

extension HTTP.Request where Endpoint == StackoverflowService.LoadQuestion, Output == PostsDTO<QuestionDTO> {
    func callAsFunction(id: QuestionId) -> Response {
        guard let urlString = String(format: urlMask, id).urlQueryAllowed else {
            return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
        }
        print("Loading question by id (\(id)): \(urlString)")
        return process(urlString)
    }
}

extension HTTP.Request where Endpoint == StackoverflowService.LoadAnswer, Output == PostsDTO<AnswerDTO> {
    func callAsFunction(id: AnswerId) -> Response {
        guard let urlString = String(format: urlMask, id).urlQueryAllowed else {
            return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
        }
        print("Loading answer by id (\(id)): \(urlString)")
        return process(urlString)
    }
}

extension HTTP.Request where Endpoint == StackoverflowService.LoadAnswers, Output == PostsDTO<AnswerDTO> {
    func callAsFunction(questionId: QuestionId, page: Int, pageSize: Int) -> Response {
        guard let urlString = String(format: urlMask, questionId, page, pageSize).urlQueryAllowed else {
            return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
        }
        print("Loading answer for question [\(questionId)]: \(urlString)")
        return process(urlString)
    }
}
