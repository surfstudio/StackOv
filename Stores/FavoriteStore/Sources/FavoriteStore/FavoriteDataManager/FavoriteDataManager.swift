//
//  FavoriteDataManager.swift
//  StackOv (FavoriteStore module)
//
//  Created by Erik Basargin
//  Copyright © 2021 Erik Basargin. All rights reserved.
//

import Foundation
import Combine
import StackexchangeNetworkService
import DataTransferObjects
import Palette
import Common
import struct SwiftUI.Color

final public class FavoriteDataManager: FavoriteDataManagerProtocol {
    
    // MARK: - Nested types
    
    enum Constants {
        static let defaultPage = 1
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
    var currentData: CollectedData?
    var loadingProcess: AnyCancellable?
    
    // MARK: - Private properties
    
    private let colors = Palette.postBackgroundGradients
    private var colorIndex: Int = 0
    
    // MARK: - Initialization and deinitialization
    
    public init(service: StackexchangeNetworkService) {
        self.service = service
        resetColorStartIndex()
    }
    
    deinit {
        cancelLoadingProcess()
    }
    
    // MARK: - Internal methods
    
    func cancelLoadingProcess() {
        loadingProcess?.cancel()
        loadingProcess = nil
    }
    
    // MARK: - Private methods
    
    private func nextBunchOfColors(step: Int) -> (top: Color, bottom: Color) {
        colorIndex += step
        return colors[colorIndex % colors.count]
    }
    
    private func resetColorStartIndex() {
        colorIndex = (0..<colors.count).randomElement() ?? .zero
    }
}

public extension FavoriteDataManager {
    
    func fetch(receiveCompletion: @escaping ResultHandler) {
        guard !isLoading, hasMoreData else { return }
        
        loadingProcess = service
            .get("/questions?order=desc&sort=votes&page=\(page)&pagesize=\(Constants.defaultPageSize)")
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { [unowned self] completion in
                cancelLoadingProcess()
                switch completion {
                case .finished:
                    page += 1
                case let .failure(error):
                    receiveCompletion(.failure(error))
                }
            }) { [unowned self] (data: QuestionsEntry) in
                let newData: [QuestionModel] = data.items.enumerated().map { index, item in
                    let colors = nextBunchOfColors(step: index)
                    return QuestionModel.from(entry: item, withGradientColors: colors)
                }
                hasMoreData = data.hasMore
                currentData = (currentData ?? []) + newData
                receiveCompletion(.success(currentData ?? []))
            }
    }
    
    func reload(receiveCompletion: @escaping ResultHandler) {
        cancelLoadingProcess()
        loadingProcess = service
            .get("/questions?order=desc&sort=votes&page=\(Constants.defaultPage)&pagesize=\(Constants.defaultPageSize)")
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
            }) { [unowned self] (data: QuestionsEntry) in
                let newData: [QuestionModel] = data.items.enumerated().map { index, item in
                    let colors = nextBunchOfColors(step: index)
                    return QuestionModel.from(entry: item, withGradientColors: colors)
                }
                hasMoreData = data.hasMore
                currentData = (currentData ?? []) + newData
                receiveCompletion(.success(currentData ?? []))
            }
    }
    
    func reset() {
        currentData = nil
        page = Constants.defaultPage
        resetColorStartIndex()
        cancelLoadingProcess()
        hasMoreData = true
    }
}
