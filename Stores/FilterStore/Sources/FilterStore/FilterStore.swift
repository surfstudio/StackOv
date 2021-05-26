//
//  FilterStore.swift
//  StackOv (FilterStore module)
//
//  Created by Evgeny Novgorodov
//  Copyright © 2021 Erik Basargin. All rights reserved.
//

import Foundation

public final class FilterStore: ObservableObject {
    
    // MARK: - Nested types
    
    public typealias FilterState = Set<FilterOption>
    
    public enum FilterOption: Int, CaseIterable, Identifiable {
        case noAnswers
        case noAcceptedAnswer
        case hasBounty
    }
    
    public enum SortOption: Int, CaseIterable, Identifiable {
        case newest
        case recentActivity
        case mostVotes
        case bountyEditingSoon
    }
    
    // MARK: - Public properties
    
    @Published public private(set) var filterState: FilterState = []
    @Published public private(set) var sortState: SortOption = .newest
    
    // MARK: - Initialization and deinitialization
    
    public init() {
        fetchStates()
    }
    
    // MARK: - Private methods
    
    private func fetchStates() {
        if let filterData = UserDefaults.standard.value(forKey: "filterState") as? [Int] {
            let filterOptions = filterData.compactMap { FilterOption.init(rawValue: $0) }
            filterState = Set(filterOptions)
        }
        if let sortData = UserDefaults.standard.value(forKey: "sortState") as? Int {
            guard let sortOption = SortOption.init(rawValue: sortData) else { return }
            sortState = sortOption
        }
    }
}

// MARK: - Actions

public extension FilterStore {
    
    func setFilterState(to filterState: FilterState) {
        self.filterState = filterState
    }
    
    func setSortState(to sortState: SortOption) {
        self.sortState = sortState
    }
    
    func saveStates() {
        UserDefaults.standard.set(filterState.map { $0.rawValue }, forKey: "filterState")
        UserDefaults.standard.set(sortState.rawValue, forKey: "sortState")
    }
}

// MARK: - Extensions

public extension FilterStore.FilterOption {
    
    var id: Int {
        hashValue
    }
}

public extension FilterStore.SortOption {
    
    var id: Int {
        hashValue
    }
}
