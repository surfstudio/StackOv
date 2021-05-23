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
import Common
import struct CoreGraphics.CGFloat

public final class PageStore: ObservableObject {
    
    // MARK: - Nested types
    
    public enum State {
        case unknown
        case emptyContent
        case content([QuestionModel])
        case loading
        case error(Error)
    }
    
    // MARK: - Substores & Services
    
    public let filterStore: FilterStore
    
    private(set) var itemSizeCache: [CGFloat: CGFloat]
    
    let dataManager: PageDataManagerProtocol
    
    // MARK: - Public properties
    
    @Published public private(set) var state: State = .unknown
    @Published public private(set) var loadMore: Bool = false
    @Published public private(set) var itemCollectionWidth: CGFloat = .zero
    
    // MARK: - Initialization and deinitialization
    
    public init(dataManager: PageDataManagerProtocol, filterStore: FilterStore) {
        self.dataManager = dataManager
        self.filterStore = filterStore
        self.itemSizeCache = [:]
    }
}

// MARK: - Actions

public extension PageStore {
    
    func prepareCollectionItemWidthFor(mainContentWidth contentWidth: CGFloat) {
        if let width = itemSizeCache[contentWidth] {
            itemCollectionWidth = width
            return
        }
        
        let collectionWidth = contentWidth - 2 * PageConstrants.defaultSpacing
        let maxColumnsNumber: Int = {
            let first = contentWidth - PageConstrants.defaultSpacing
            let second = PageConstrants.gridItemMinimumWidth + PageConstrants.defaultSpacing
            return Int(first / second)
        }()
        let currentMinItemWidth: CGFloat = {
            let first = (collectionWidth + PageConstrants.defaultSpacing) / CGFloat(maxColumnsNumber)
            return first - PageConstrants.defaultSpacing
        }()
        
        let width = currentMinItemWidth - ThreadItemConstants.defaultPadding * 2
        itemSizeCache[contentWidth] = width
        itemCollectionWidth = width
    }
    
    func firstReloadQuestions() {
        loadMore = false
        state = .loading
        dataManager.reload { [unowned self] result in
            switch result {
            case let .success(models):
                state = models.isEmpty ? .emptyContent : .content(models)
            case let .failure(error):
                state = .error(error)
                GlobalBanner.show(error: error)
            }
        }
    }

    func loadNextQuestions() {
        loadMore = true
        dataManager.fetch { [unowned self] result in
            loadMore = false
            switch result {
            case let .success(models):
                if models.isEmpty { break }
                state = .content(models)
            case let .failure(error):
                GlobalBanner.show(error: error)
            }
        }
    }
}
