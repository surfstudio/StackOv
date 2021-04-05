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

public final class ThreadStore: ObservableObject {
    
    // MARK: - Nested types
    
    public enum State {
        case unknown
        case emptyContent
        case content([AnswerModel])
        case loading
        case error(Error)
    }
    
    public enum LoadingType {
        case reload
        case next
    }
    
    // MARK: - Substores & Services
    
    let dataManager: ThreadDataManagerProtocol

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
}

// MARK: - Actions

public extension ThreadStore {

    func firstReloadAnswers() {
        loadMore = false
        state = .loading
        dataManager.reload(questionId: questionModel.id) { [unowned self] result in
            switch result {
            case let .success(models):
                state = models.isEmpty ? .emptyContent : .content(models)
            case let .failure(error):
                state = .error(error)
            }
        }
    }
    
    func loadNextAnswers() {
        loadMore = true
        dataManager.fetch(questionId: questionModel.id) { [unowned self] result in
            loadMore = false
            switch result {
            case let .success(models):
                if models.isEmpty { break }
                state = .content(models)
            case .failure:
                break
            }
        }
    }
}

// MARK: - Private Methods

private extension ThreadStore {
    
    func loadAccepterdAnswer(answerId: Int) {
        dataManager.loadAnswer(by: answerId, receiveCompletion: { [unowned self] result in
            
        })
    }

}
