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
            VStack(alignment: .leading, spacing: 0) {
                Spacer()
                
                HStack(spacing: 17) {
                    checkmark
                    
                    Text(filterOption.rawValue)
                        .bold()
                        .foregroundColor(Color.foreground)
                }
                
                Spacer()
                
                Divider()
                    .padding(.leading, filterOption.isLast ? -22 : 38)
            }
            .padding(.leading, 22)
        }
        .frame(height: 48)
        .background(Color.background)
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

// MARK: - Estensions

fileprivate extension FilterOption {
    
    var isLast: Bool {
        self == Self.allCases.last
    }
}

// MARK: - Colors

fileprivate extension Color {
    
    static let foreground = Palette.white
    static let background = Palette.grayblue
}
