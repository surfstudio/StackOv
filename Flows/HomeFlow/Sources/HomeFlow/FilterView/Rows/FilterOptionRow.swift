//
//  FilterOptionRow.swift
//  StackOv (HomeFlow module)
//
//  Created by Evgeny Novgorodov
//  Copyright © 2021 Erik Basargin. All rights reserved.
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
                    CheckmarkView(isSelected: statesOfFilters[filterOption] ?? false, isFilled: true)
                    
                    Text(filterOption.rawValue)
                        .font(.headline)
                        .fontWeight(.medium)
                        .lineLimit(1)
                        .foregroundColor(Color.foreground)
                }
                
                Spacer()
                
                // FIXME: During accessibility leading inset is wrong
                Divider()
                    .padding(.leading, filterOption.isLast ? -22 : 38)
            }
            .padding(.leading, 22)
        }
        .frame(minHeight: 48)
        .background(Color.background)
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
