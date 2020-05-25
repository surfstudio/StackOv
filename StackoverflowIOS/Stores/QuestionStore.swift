//
//  QuestionStore.swift
//  StackoverflowIOS
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
        case loading
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
    
    // MARK: - Parameters
    
    @Published private(set) var state: State = .unknown
    
    lazy var service = StackoverflowService()

    private var cancelBag: Set<AnyCancellable> = []
    private var loadingProcess: AnyCancellable?
    
    // MARK: - Initializing and deinitializing
    
    deinit {
        print("Deinit")
        cancelLoadingProcess()
        cancelBag.forEach { $0.cancel() }
    }
    
    // MARK: - Methods
    
    func reload(forQuestionId id: QuestionId) {
        if case let .content(model) = state, model.id == id {
            return
        }
        cancelLoadingProcess()
        state = .unknown
    }
    
    func cancelLoadingProcess() {
        print("Process will cancel")
        loadingProcess?.cancel()
        loadingProcess = nil
    }
    
    func loadQuestion(id: QuestionId) {
        print("Process loadQuestion")
        state = .loading
        cancelLoadingProcess()
        loadingProcess = service.loadQuestion(id: id)
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { completion in
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
}
