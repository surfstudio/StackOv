//
//  AnswersStore.swift
//  StackOv
//
//  Created by Erik Basargin on 23/05/2020.
//  Copyright © 2020 Ephedra Software. All rights reserved.
//

import Foundation
import SwiftUI
import Combine

final class AnswersStore: ObservableObject {
    // MARK: - Nested types
    
    enum State {
        case unknown
        case emptyContent
        case content([AnswerModel])
        case loading
        case error(Error)
    }
    
    enum LoadingState {
        case loadAnswers(page: Int, pageSize: Int)
    }
    
    enum LoadingStep {
        case reload
        case next
    }
    
    // MARK: - Parameters
    
    @Published private(set) var state: State = .unknown
    @Published private(set) var hasMore: Bool = false
    
    private lazy var service = StackoverflowService()
    private var questionId: QuestionId?
    
    var isLoading: Bool {
        loadingProcess != nil
    }

    private var loadingState: LoadingState = .loadAnswers(page: 0, pageSize: 5)
    private var cancelBag: Set<AnyCancellable> = []
    private var loadingProcess: AnyCancellable?
    
    // MARK: - Initializing and deinitializing
    
    deinit {
        cancelLoadingProcess()
        cancelBag.forEach { $0.cancel() }
    }
    
    // MARK: - Methods
    
    func cancel() {
        print("[AnswersStore] Reload process")
        cancelLoadingProcess()
        state = .unknown
        hasMore = false
        questionId = nil
        loadingState = .loadAnswers(page: 0, pageSize: 5)
    }
    
    func setNeedHasMore(_ value: Bool) {
        hasMore = value
    }
    
    func cancelLoadingProcess() {
        print("[AnswersStore] Loading process will cancel")
        loadingProcess?.cancel()
        loadingProcess = nil
    }
    
    func reload(byQuestion question: QuestionModel) {
        questionId = question.id
        if let id = question.acceptedAnswerId {
            setNeedHasMore(question.answerCount > 1)
            loadAnswer(id: id)
        } else if question.answerCount != .zero {
            setNeedHasMore(false)
            loadAnswers(.reload)
        } else {
            setNeedHasMore(false)
        }
    }
    
    func loadAnswer(id: AnswerId) {
        guard loadingProcess == nil else {
            return
        }
        print("[AnswersStore] Process loadAnswer \(id)")
        state = .loading
        loadingProcess = service.loadAnswer(id: id)
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { [unowned self] completion in
                self.cancelLoadingProcess()
                guard case let .failure(error) = completion else {
                    return
                }
                self.state = .error(error)
            }) { [unowned self] data in
                guard let answerData = data.items.first else {
                    return
//                    self.state = .error(<#Error#>)
                }
                self.state = .content([AnswerModel.from(dto: answerData)])
            }
    }
    
    func loadAnswers(_ step: LoadingStep) {
        guard loadingProcess == nil, let questionId = questionId else {
            return
        }
        switch step {
        case .reload:
            state = .loading
            loadingState = .loadAnswers(page: 1, pageSize: 5)
        case .next:
            loadingState += 1
        }
        print("[AnswersStore] Process loadAnswers \(loadingState)")
        loadingProcess = service.loadAnswers(questionId: questionId, page: loadingState.page, pageSize: loadingState.pageSize)
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { [unowned self] completion in
                self.cancelLoadingProcess()
                guard case let .failure(_) = completion else {
                    return
                }
//                self.state = .error(error)
                self.hasMore = true
            }) { [unowned self] data in
                let answers = data.items.map { AnswerModel.from(dto: $0) }.filter { !$0.isAccepted }
                switch step {
                case .reload:
                    self.state = answers.isEmpty ? .emptyContent : .content(answers)
                case .next:
                    let content = self.state.content + answers
                    self.state = content.isEmpty ? .emptyContent : .content(content)
                }
                self.hasMore = data.hasMore
        }
    }
}

// MARK: - Extensions

extension AnswersStore.State {
    var content: [AnswerModel] {
        if case let .content(answers) = self { return answers }
        return []
    }
    
    var error: Error? {
        if case let .error(error) = self { return error }
        return nil
    }
    
    var isUnknown: Bool {
        if case .unknown = self { return true }
        return false
    }
}

fileprivate extension AnswersStore.LoadingState {
    var page: Int {
        switch self {
        case let .loadAnswers(page, _):
            return page
        }
    }
    
    var pageSize: Int {
        switch self {
        case let .loadAnswers(_, pageSize):
            return pageSize
        }
    }
    
    static func +=(lhs: inout Self, rhs: Int) {
        switch lhs {
        case let .loadAnswers(page, pageSize):
            lhs = .loadAnswers(page: page + rhs, pageSize: pageSize)
        }
    }
}
