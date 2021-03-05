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
    
    public enum LoadingType {
        case reload
        case next
    }
    
    // MARK: - Substores & Services

    let dataManager: PageDataManagerProtocol
    public let filterStore: FilterStore
    
    // MARK: - Public properties
    
    @Published public private(set) var state: State = .unknown

    // MARK: - Private properties

    private var models = [QuestionModel]()

    // MARK: - Initialization and deinitialization
    
    public init(dataManager: PageDataManagerProtocol, filterStore: FilterStore) {
        self.dataManager = dataManager
        self.filterStore = filterStore
    }
}

// MARK: - Actions

public extension PageStore {

    // MARK: - Public methods

    func tryLoadMoreIfNeeded(current item: QuestionModel) {
        guard let currentItemIndex = models.firstIndex(where: { $0.id == item.id } ),
              models.count <= currentItemIndex + Constants.leftItemsCountToPrefetching else {
            return
        }
        loadQuestions(.next)
    }
    
    func loadQuestions(_ type: LoadingType = .reload) {
        switch type {
        case .reload:
            dataManager.reset()
            models.removeAll()
        case .next:
            tryLoadResultAndUpdateState { _ in
                //not implemented yet
            }
            return
        }
        state = .loading
        tryLoadResultAndUpdateState { [unowned self] error in
            self.state = .error(error)
        }
    }

    // MARK: - Private methods

    private func tryLoadResultAndUpdateState(_ onError: @escaping (Error) -> Void) {
        dataManager.fetch { [unowned self] result in
            switch result {
            case let .success(models):
                self.models.append(contentsOf: models)
                self.state = models.isEmpty ? .emptyContent : .content(models)
            case let .failure(error):
                onError(error)
            }
        }
    }

}
