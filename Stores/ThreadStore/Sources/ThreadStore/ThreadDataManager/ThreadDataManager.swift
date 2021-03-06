//
//  ThreadDataManager.swift
//  StackOv (ThreadStore module)
//
//  Created by Влад Климов
//  Copyright © 2021 Erik Basargin. All rights reserved.
//

import Foundation
import Common
import Combine
import StackexchangeNetworkService
import DataTransferObjects

final public class ThreadDataManager: ThreadDataManagerProtocol {
    
    // MARK: - Nested Types
    
    enum Constants {
        static let defaultPage = 1
        static let defaultPageSize = 6
    }
    
    // MARK: - Services
    
    let service: StackexchangeNetworkService
    
    // MARK: - Public Properties
    
    public var data: CollectedData? {
        currentData
    }
    
    public var isLoading: Bool {
        loadingProcess != nil
    }
    
    public var hasMoreData: Bool = true
    
    // MARK: - Internal Properties
    
    var page: Int = Constants.defaultPage
    var currentData: CollectedData?
    var loadingProcess: AnyCancellable?
    
    // MARK: - Initialization and deinitialization
    
    public init(service: StackexchangeNetworkService) {
        self.service = service
    }
    
    deinit {
        cancelLoadingProcess()
    }
    
    // MARK: - Internal Methods
    
    func cancelLoadingProcess() {
        loadingProcess?.cancel()
        loadingProcess = nil
    }
    
}

// MARK: - Public Methods

public extension ThreadDataManager {
    
    func fetch(questionId: Int, receiveCompletion: @escaping ResultHandler) {
        guard !isLoading, hasMoreData else { return }
        
        loadingProcess = service
            .get("/questions/\(questionId)/answers?order=desc&sort=votes&page=\(page)&pagesize=\(Constants.defaultPageSize)")
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { [unowned self] completion in
                cancelLoadingProcess()
                switch completion {
                case .finished:
                    page += 1
                case let .failure(error):
                    receiveCompletion(.failure(error))
                }
            }, receiveValue: { [unowned self] (data: AnswersEntry) in
                let newData: [AnswerModel] = data.items.enumerated().map { index, item in
                    return AnswerModel.from(entry: item)
                }
                hasMoreData = data.hasMore
                
                let actualData = newData.filter { !(currentData ?? []).contains($0) }
                currentData = (currentData ?? []) + actualData
                receiveCompletion(.success(currentData ?? []))
            })
    }
    
    func reload(questionId: Int, receiveCompletion: @escaping ResultHandler) {
        cancelLoadingProcess()
        loadingProcess = service
            .get("/questions/\(questionId)/answers?order=desc&sort=votes&page=\(Constants.defaultPage)&pagesize=\(Constants.defaultPageSize)")
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { [unowned self] completion in
                cancelLoadingProcess()
                switch completion {
                case .finished:
                    reset()
                    page += 1
                case let .failure(error):
                    receiveCompletion(.failure(error))
                }
            }) { [unowned self] (data: AnswersEntry) in
                let newData: [AnswerModel] = data.items.enumerated().map { index, item in
                    return AnswerModel.from(entry: item)
                }
                hasMoreData = data.hasMore
                currentData = (currentData ?? []) + newData
                receiveCompletion(.success(currentData ?? []))
            }
    }
    
    func reload(acceptedId: Int, receiveCompletion: @escaping ResultHandler) {
        cancelLoadingProcess()
        loadingProcess = service
            .get("/answers/\(acceptedId)")
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { [unowned self] completion in
                cancelLoadingProcess()
                switch completion {
                case .finished:
                    reset()
                case let .failure(error):
                    receiveCompletion(.failure(error))
                }
            }) { [unowned self] (data: AnswersEntry) in
                let newData: [AnswerModel] = data.items.enumerated().map { index, item in
                    return AnswerModel.from(entry: item)
                }
                currentData = (currentData ?? []) + newData
                receiveCompletion(.success(currentData ?? []))
            }
    }
    
    func reset() {
        currentData = nil
        page = Constants.defaultPage
        cancelLoadingProcess()
        hasMoreData = true
    }

}
