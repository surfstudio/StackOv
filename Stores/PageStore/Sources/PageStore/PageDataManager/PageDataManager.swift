//
//  PageDataManager.swift
//  StackOv (PageStore module)
//
//  Created by Erik Basargin
//  Copyright © 2021 Erik Basargin. All rights reserved.
//

import Foundation
import Combine
import StackexchangeNetworkService
import Palette
import struct SwiftUI.Color

final public class PageDataManager: PageDataManagerProtocol {
    
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

public extension PageDataManager {
    
    func fetch(_ complitionHandler: @escaping FetchComplitionHandler) {
        guard !isLoading, hasMoreData else { return }

        loadingProcess = service.loadQuestions(page: page, pageSize: Constants.defaultPageSize)
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { [unowned self] completion in
                cancelLoadingProcess()
                guard case let .failure(error) = completion else {
                    return
                }
                complitionHandler(.failure(error))
            }) { [unowned self] data in
                let newData: [QuestionModel] = data.items.enumerated().map { index, item in
                    let colors = nextBunchOfColors(step: index)
                    return QuestionModel.from(entry: item, withGradientColors: colors)
                }
                hasMoreData = data.hasMore
                currentData = (currentData ?? []) + newData
                page += 1
                complitionHandler(.success(currentData ?? []))
            }
    }

    func reload(_ complitionHandler: @escaping FetchComplitionHandler) {
        guard !isLoading else { return }

        loadingProcess = service.loadQuestions(page: Constants.defaultPage, pageSize: Constants.defaultPageSize)
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { [unowned self] completion in
                cancelLoadingProcess()
                guard case let .failure(error) = completion else {
                    return
                }
                complitionHandler(.failure(error))
            }) { [unowned self] data in
                let newData: [QuestionModel] = data.items.enumerated().map { index, item in
                    let colors = nextBunchOfColors(step: index)
                    return QuestionModel.from(entry: item, withGradientColors: colors)
                }
                reset()
                hasMoreData = data.hasMore
                currentData = (currentData ?? []) + newData
                page += 1
                complitionHandler(.success(currentData ?? []))
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
