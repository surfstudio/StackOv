//
//  PageStore.swift
//  StackOv (PageStore module)
//
//  Created by Erik Basargin
//  Copyright © 2021 Erik Basargin. All rights reserved.
//

import Foundation
import Combine
import StackexchangeNetworkService

public final class PageStore: ObservableObject {
    
    // MARK: - Nested types
    
    public enum State {
        case unknown
        case emptyContent
        case content([QuestionModel])
        case loading
        case error(Error)
    }
    
    public enum LoadingType {
        case reload
        case next
    }
    
    // MARK: - Substores & Services

    let dataManager: PageDataManagerProtocol
//    let filterStore: 
    
    // MARK: - Public properties
    
    @Published public private(set) var state: State = .unknown

    // MARK: - Initialization and deinitialization
    
    public init(dataManager: PageDataManagerProtocol) {
        self.dataManager = dataManager
    }
}

// MARK: - Actions

public extension PageStore {
    
    func loadQuestions(_ type: LoadingType = .reload) {
        switch type {
        case .reload:
            dataManager.reset()
        case .next:
            break
        }
        state = .loading
        dataManager.fetch { [unowned self] result in
            switch result {
            case let .success(models):
                self.state = models.isEmpty ? .emptyContent : .content(models)
            case let .failure(error):
                self.state = .error(error)
            }
        }
    }
}
