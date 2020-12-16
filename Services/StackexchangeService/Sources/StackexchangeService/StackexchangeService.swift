//
//  StackexchangeService.swift
//  This source file is part of the StackOv open source project
//

import Foundation
import Network
import Common
import Logging

public struct StackexchangeService {
    
    // MARK: - Nested types
    
    enum Constants {
        static let baseUrl = URL(string: "https://api.stackexchange.com/2.2")!
        static let questionsFilter = "!*7PZ(S77sKA3Rc8i4h4)QI0bM8HG"
        static let questionFilter = "!PvyfxTBzonJRcqwIa*BHYvqSvHDWMY"
        static let answerFilter = "!3xJkL2qoqNZw7Litv"
        static let quotaKey = "P8uUWwsGz2WbRs6)qHu)yw(("
    }
    
    // MARK: - Endpoints
    
    public enum LoadQuestions {}
    public enum SearchQuestions {}
    public enum LoadQuestion {}
    public enum LoadAnswer {}
    public enum LoadAnswers {}
    
    // MARK: - Logger
    
    static let logger: Logger = {
        var logger = Logger(label: "Stackexchange service logger")
        #if DEBUG
        logger.logLevel = .debug
        #else
        logger.logLevel = .critical
        #endif
        return logger
    }()
    
    // MARK: - Initializers
    
    public init() {}
    
    // MARK: - Requests
    
    @GET(Constants.baseUrl, "/questions?order=desc&sort=votes&page=%d&pagesize=%d")
    public var loadQuestions: Request<LoadQuestions, PostsDTO<QuestionDTO>>
    
    @GET(Constants.baseUrl, "/search/advanced?order=desc&sort=votes&q=%@&page=%d&pagesize=%d")
    public var searchQuestions: Request<SearchQuestions, PostsDTO<QuestionDTO>>
    
    @GET(Constants.baseUrl, "/questions/%d")
    public var loadQuestion: Request<LoadQuestion, PostsDTO<QuestionDTO>>
    
    @GET(Constants.baseUrl, "/answers/%d")
    public var loadAnswer: Request<LoadAnswer, PostsDTO<AnswerDTO>>
    
    @GET(Constants.baseUrl, "/questions/%d/answers?order=desc&sort=votes&page=%d&pagesize=%d")
    public var loadAnswers: Request<LoadAnswers, PostsDTO<AnswerDTO>>
}
