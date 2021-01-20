//
//  FilterView.swift
//  
//
//  Created by User on 19.01.2021.
//

import SwiftUI
import Palette

typealias StatesOfFilters = [FilterOption: Bool]
typealias StatesOfSorts = [SortOption: Bool]

extension StatesOfSorts {
    
    mutating func reset() {
        self = mapValues { _ in false }
    }
}

struct FilterView: View {
    
    // MARK: - States
    
    @State var statesOfFilters: StatesOfFilters = {
        var states = [FilterOption: Bool]()
        FilterOption.allCases.forEach { states[$0] = Bool.random() }
        return states
    }()
    
    @State var statesOfSorts: StatesOfSorts = {
        var states = [SortOption: Bool]()
        SortOption.allCases.forEach { states[$0] = false }
        return states
    }()
    
    @Binding var isFilterViewPresented: Bool
    
    var body: some View {
        header
            .padding()
        
        list
    }
    
    var header: some View {
        HStack {
            Button(action: {
                isFilterViewPresented = false
            }) {
                Text("Cancel")
                    .bold()
                    .foregroundColor(Color.main)
            }
            
            Spacer()
            
            Text("Filter")
                .bold()
            
            Spacer()
            
            Button(action: {}) {
                Text("Done")
                    .bold()
                    .foregroundColor(Color.main)
            }
        }
    }
    
    var list: some View {
        List {
            Section(header: Text("Filter by")) {
                ForEach(FilterOption.allCases, id: \.self) { filterOption in
                    FilterOptionRow(statesOfFilters: $statesOfFilters,
                                    filterOption: filterOption)
                }
            }
            .frame(height: 50)
            
            Section(header: Text("Sorted by")) {
                ForEach(SortOption.allCases, id: \.self) { sortOption in
                    SortOptionRow(statesOfSorts: $statesOfSorts,
                                  sortOption: sortOption)
                }
            }
            .frame(height: 50)
        }
    }
}

struct FilterView_Previews: PreviewProvider {
    static var previews: some View {
        FilterView(isFilterViewPresented: .constant(true))
    }
}

// MARK: - Colors

fileprivate extension Color {
    
    static let main = Palette.main
}
