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
import FilterStore

public final class PageStore: ObservableObject {
    
    // MARK: - Nested types

    private enum Constants {
        static let leftItemsCountToPrefetching = 3
    }
    
    public enum State {
        case unknown
        case emptyContent
        case content([QuestionModel])
        case loading
        case error(Error)
    }
    
    // MARK: - Substores & Services

    let dataManager: PageDataManagerProtocol
    public let filterStore: FilterStore
    
    // MARK: - Public properties
    
    @Published public private(set) var state: State = .unknown

    // MARK: - Initialization and deinitialization
    
    public init(dataManager: PageDataManagerProtocol, filterStore: FilterStore) {
        self.dataManager = dataManager
        self.filterStore = filterStore
    }
}

// MARK: - Actions

public extension PageStore {

    func loadNextQuestions() {
        dataManager.fetch { [unowned self] result in
            switch result {
            case let .success(models):
                if models.isEmpty { break }
                self.state = .content(models)
            case .failure:
                // need show error not by changing the state of screen
               break
            }
        }
    }

    func reloadQuestions() {
        state = .loading
        dataManager.reload { [unowned self] result in
            switch result {
            case let .success(models):
                self.state = models.isEmpty ? .emptyContent : .content(models)
            case .failure:
                // TODO: - Handle error without kick data from view
                break
            }
        }
    }
}
