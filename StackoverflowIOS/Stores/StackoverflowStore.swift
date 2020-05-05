//
//  StackoverflowStore.swift
//  StackoverflowIOS
//
//  Created by Erik Basargin on 05/05/2020.
//  Copyright © 2020 Ephedra Software. All rights reserved.
//

import Foundation
import Combine

final class StackoverflowStore: ObservableObject {
    lazy var service = StackoverflowService()
    
    enum State {
        case unknown
        case emptyContent
        case content([QuestionItemModel])
        case loading
        case error(Error)
        
        var content: [QuestionItemModel] {
            if case let .content(questions) = self { return questions }
            return []
        }
        
        var error: Error? {
            if case let .error(error) = self { return error }
            return nil
        }
    }
    
    @Published var state: State = .unknown
    
    private var cancelBag: Set<AnyCancellable> = []
    
    func loadQuestions() {
        state = .loading
        service.loadQuestions()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [unowned self] completion in
                guard case let .failure(error) = completion else {
                    return
                }
                self.state = .error(error)
            }) { [unowned self] items in
                let questions = items.map { QuestionItemModel.from(dto: $0) }
                self.state = questions.isEmpty ? .emptyContent : .content(questions)
            }
            .store(in: &cancelBag)
    }
    
    deinit {
        cancelBag.forEach { $0.cancel() }
    }
}
