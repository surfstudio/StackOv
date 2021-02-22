//
//  SortOptionRow.swift
//  StackOv (HomeFlow module)
//
//  Created by Evgeny Novgorodov
//  Copyright © 2021 Erik Basargin. All rights reserved.
//

import SwiftUI
import Palette
import Components
import FilterStore

struct SortOptionRow: View {
    
    // MARK: - States
    
    @Binding var selectedOption: FilterStore.SortOption
    
    // MARK: - Properties
    
    let option: FilterStore.SortOption
    
    // MARK: - Initialization
    
    init(option: FilterStore.SortOption, selected selectedOption: Binding<FilterStore.SortOption>) {
        self.option = option
        self._selectedOption = selectedOption
    }
    
    // MARK: - View
    
    var body: some View {
        Button(action: { selectedOption = option }) {
            VStack(alignment: .leading, spacing: 0) {
                Spacer()
                
                HStack(spacing: 17) {
                    CheckmarkView(isSelected: option == selectedOption, isFilled: false)
                    
                    Text(option.title)
                        .font(.headline)
                        .fontWeight(.medium)
                        .lineLimit(1)
                        .foregroundColor(Color.foreground)
                }
                
                Spacer()
                
                // FIXME: During accessibility leading inset is wrong
                Divider()
                    .padding(.leading, option.isLast ? -22 : 38)
            }
            .padding(.leading, 22)
        }
        .frame(minHeight: 48)
        .background(Color.background)
    }
}

// MARK: - Previews

struct SortOptionRow_Previews: PreviewProvider {
    
    static var previews: some View {
        SortOptionRow(option: .newest, selected: .constant(.newest))
    }
}

// MARK: - Estensions

fileprivate extension FilterStore.SortOption {
    
    var isLast: Bool {
        self == Self.allCases.last
    }
    
    var title: String {
        switch self {
        case .newest:
            return "Newest"
        case .recentActivity:
            return "Recent activity"
        case .mostVotes:
            return "Most votes"
        case .bountyEditingSoon:
            return "Bounty editing soon"
        }
    }
}

// MARK: - Colors

fileprivate extension Color {
    
    static let foreground = Palette.white
    static let background = Palette.grayblue
}
