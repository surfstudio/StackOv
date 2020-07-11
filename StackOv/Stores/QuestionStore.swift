//
//  QuestionStore.swift
//  StackOv
//
//  Created by Erik Basargin on 16/05/2020.
//  Copyright © 2020 Ephedra Software. All rights reserved.
//

import Foundation
import SwiftUI
import Combine

final class QuestionStore: ObservableObject {
    // MARK: - Nested types
    
    enum State {
        case unknown
        case emptyContent
        case content(QuestionModel)
        case loading(QuestionId)
        case error(Error)
    }
    
    enum LoadingState {
        case loadQuestions(page: Int, pageSize: Int)
        case searchQuestion(page: Int, pageSize: Int)
    }
    
    enum LoadingStep {
        case reload
        case next
    }
    
    // MARK: - Substores
    
    private(set) lazy var answersStore = AnswersStore()
    
    // MARK: - Parameters
    
    @Published private(set) var state: State = .unknown
    
    private lazy var service = StackoverflowService()

    private var cancelBag: Set<AnyCancellable> = []
    private var loadingProcess: AnyCancellable?
    
    // MARK: - Initializing and deinitializing
    
    init() {
        $state.receive(on: RunLoop.main).sink { [unowned self] state in
            switch state {
            case let .content(model):
                self.answersStore.reload(byQuestion: model)
            default:
                self.answersStore.cancel()
            }
        }
        .store(in: &cancelBag)
    }
    
    deinit {
        cancelLoadingProcess()
        cancelBag.forEach { $0.cancel() }
    }
    
    // MARK: - Methods
    
    func cancel() {
        print("[QuestionStore] Reload process")
        cancelLoadingProcess()
        state = .unknown
    }
    
    func cancelLoadingProcess() {
        print("[QuestionStore] Loading process will cancel")
        loadingProcess?.cancel()
        loadingProcess = nil
    }
    
    func reload(byId questionId: QuestionId?) {
        guard let id = questionId, id != state.currentId else {
            return
        }
        cancel()
        loadQuestion(id: id)
    }
    
    func reload() {
        guard let id = state.currentId else {
            return
        }
        cancel()
        loadQuestion(id: id)
    }
    
    func loadQuestion(id: QuestionId) {
        guard loadingProcess == nil else {
            return
        }
        print("[QuestionStore] Process loadQuestion \(id)")
        state = .loading(id)
        loadingProcess = service.loadQuestion(id: id)
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { [unowned self] completion in
                self.cancelLoadingProcess()
                guard case let .failure(error) = completion else {
                    return
                }
                self.state = .error(error)
            }) { [unowned self] data in
                guard let questionData = data.items.first else {
                    return
//                    self.state = .error(<#Error#>)
                }
                self.state = .content(QuestionModel.from(dto: questionData))
            }
    }
}

// MARK: - Extensions

extension QuestionStore.State {
    var content: QuestionModel? {
        if case let .content(question) = self { return question }
        return nil
    }
    
    var error: Error? {
        if case let .error(error) = self { return error }
        return nil
    }
    
    var isUnknown: Bool {
        if case .unknown = self { return true }
        return false
    }
    
    var isReady: Bool {
        if case .content = self { return true }
        return false
    }
    
    var currentId: QuestionId? {
        switch self {
        case let .content(model):
            return model.id
        case let .loading(id):
            return id
        default:
            return nil
        }
    }
}
