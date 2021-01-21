//
//  FilterOptionRow.swift
//  This source file is part of the StackOv open source project
//

import SwiftUI
import Palette
import Components

struct FilterOptionRow: View {
    
    // MARK: - States
    
    @Binding var statesOfFilters: [FilterOption: Bool]
    
    // MARK: - Properties
    
    let filterOption: FilterOption
    
    // MARK: - View
    
    var body: some View {
        Button(action: { statesOfFilters[filterOption]?.toggle() }) {
            HStack(spacing: 17) {
                checkmark
                
                Text(filterOption.rawValue)
                    .bold()
            }
        }
        .listRowInsets(EdgeInsets.leading(22))
        .frame(height: 48)
    }
    
    var checkmark: some View {
        if statesOfFilters[filterOption] ?? false {
            return CheckmarkView(isSelected: .constant(true))
        } else {
            return CheckmarkView(isSelected: .constant(false))
        }
    }
}

// MARK: - Previews

struct FilterOptionRow_Previews: PreviewProvider {
    
    static var previews: some View {
        FilterOptionRow(statesOfFilters: .constant(.init()), filterOption: .hasBounty)
    }
}
