//
//  ThreadStore.swift
//  StackOv (ThreadStore module)
//
//  Created by Erik Basargin
//  Copyright © 2021 Erik Basargin. All rights reserved.
//

import Foundation
import Combine
import StackexchangeNetworkService
import Common
import HTMLMarkdown

public final class ThreadStore: ObservableObject {
    
    // MARK: - Nested types
    
    public enum State {
        case unknown
        case emptyContent
        case content(totalAnswersNumber: Int, answers: [AnswerModel])
        case loading
        case error(Error)
    }
    
    // MARK: - Substores & Services
    
    let dataManager: ThreadDataManagerProtocol
    let unitsCash = Cache<Int, HTMLMarkdown.Unit>()

    // MARK: - States
    
    @Published public private(set) var state: State = .unknown
    @Published public private(set) var loadMore: Bool = false
    
    // MARK: - Public properties

    public let questionModel: QuestionModel

    // MARK: - Initialization and deinitialization
    
    public init(model: QuestionModel, dataManager: ThreadDataManagerProtocol) {
        self.questionModel = model
        self.dataManager = dataManager
    }
    
    // MARK: - Public methods
    
    public func unit(of model: QuestionModel) -> Result<HTMLMarkdown.Unit, Error> {
        unit(forId: model.id, htmlText: model.body)
    }
    
    public func unit(of model: AnswerModel) -> Result<HTMLMarkdown.Unit, Error> {
        unit(forId: model.id, htmlText: model.body)
    }
    
    // MARK: - Internal methods
    
    func unit(forId id: Int, htmlText: String) -> Result<HTMLMarkdown.Unit, Error> {
        if let unit = unitsCash[id] { return .success(unit) }
        do {
            let unit = try HTMLMarkdown.Unit.make(with: htmlText)
            unitsCash[id] = unit
            return .success(unit)
        } catch {
            return .failure(error)
        }
    }
}

// MARK: - Actions

public extension ThreadStore {

    func firstReloadAnswers() {
        loadMore = false
        state = .loading
        
        let receiveCompletion: (Result<[AnswerModel], Error>) -> Void = { [unowned self] result in
            switch result {
            case let .success(models):
                state = models.isEmpty
                    ? .emptyContent
                    : .content(totalAnswersNumber: questionModel.answersNumber, answers: models)
            case let .failure(error):
                GlobalBanner.show(error: error)
                state = .error(error)
            }
        }
        
        if questionModel.hasAcceptedAnswer, let id = questionModel.acceptedAnswerId {
            dataManager.reload(acceptedId: id, receiveCompletion: receiveCompletion)
        } else {
            dataManager.reload(questionId: questionModel.questionId, receiveCompletion: receiveCompletion)
        }
    }
    
    func loadNextAnswers() {
        guard dataManager.hasMoreData else { return }
        
        loadMore = true
        dataManager.fetch(questionId: questionModel.questionId) { [unowned self] result in
            loadMore = false
            switch result {
            case let .success(models):
                if models.isEmpty { break }
                state = .content(totalAnswersNumber: questionModel.answersNumber, answers: models)
            case let .failure(error):
                GlobalBanner.show(error: error)
            }
        }
    }
}
