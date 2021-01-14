//
//  PageDataManager.swift
//  This source file is part of the StackOv open source project
//

import Foundation
import Combine
import StackexchangeNetworkService

final public class PageDataManager: PageDataManagerProtocol {
    
    // MARK: - Nested types
    
    enum Constants {
        static let defaultPage = 0
        static let defaultPageSize = 30
    }
    
    // MARK: - Services
    
    let service: StackexchangeNetworkService
    
    // MARK: - Public properties
    
    public var data: CollectedData? {
        currentData
    }
    
    public var isLoading: Bool {
        loadingProcess != nil
    }
    
    public var hasMoreData: Bool = true
    
    // MARK: - Internal properties
    
    var page: Int = Constants.defaultPage
    var pageSize: Int = Constants.defaultPageSize
    var currentData: CollectedData?
    var loadingProcess: AnyCancellable?
    
    // MARK: - Initialization and deinitialization
    
    public init(service: StackexchangeNetworkService) {
        self.service = service
    }
    
    deinit {
        cancelLoadingProcess()
    }
    
    // MARK: - Internal methods
    
    func cancelLoadingProcess() {
        loadingProcess?.cancel()
        loadingProcess = nil
    }
}

public extension PageDataManager {
    
    func fetch(_ complitionHandler: @escaping FetchComplitionHandler) {
        guard !isLoading, hasMoreData else { return }
        
        page += 1
        loadingProcess = service.loadQuestions(page: page, pageSize: pageSize)
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { [unowned self] completion in
                self.cancelLoadingProcess()
                guard case let .failure(error) = completion else {
                    return
                }
                complitionHandler(.failure(error))
            }) { [unowned self] data in
                let newData = data.items.map { QuestionItemModel.from(entry: $0) }
                hasMoreData = data.hasMore
                currentData = (currentData ?? []) + newData
                complitionHandler(.success(currentData ?? []))
            }
    }
    
    func reset() {
        cancelLoadingProcess()
        hasMoreData = true
    }
}
