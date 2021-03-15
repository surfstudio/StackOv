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
import FilterStore

struct FilterOptionRow: View {

    // MARK: - States
    
    @Binding var filterState: FilterStore.FilterState
    
    // MARK: - Properties
    
    let option: FilterStore.FilterOption
    
    // MARK: - Initialization
    
    init(option: FilterStore.FilterOption, filterState: Binding<FilterStore.FilterState>) {
        self.option = option
        self._filterState = filterState
    }

    // MARK: - View

    var body: some View {
        Button(action: action) {
            VStack(alignment: .leading, spacing: 0) {
                Spacer()

                HStack(spacing: 17) {
                    CheckmarkView(isSelected: filterState.contains(option), isFilled: true)
                    
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
    
    // MARK: - View methods

    func action() {
        if filterState.contains(option) {
            filterState.remove(option)
        } else {
            filterState.insert(option)
        }
    }
}

// MARK: - Previews

struct FilterOptionRow_Previews: PreviewProvider {

    static var previews: some View {
        FilterOptionRow(option: .noAnswers, filterState: .constant([]))
    }
}

// MARK: - Estensions

fileprivate extension FilterStore.FilterOption {

    var isLast: Bool {
        self == Self.allCases.last
    }
    
    var title: String {
        switch self {
        case .noAnswers:
            return "No answers"
        case .noAcceptedAnswer:
            return "No accepted answer"
        case .hasBounty:
            return "Has bounty"
        }
    }
}

// MARK: - Colors

fileprivate extension Color {

    static let foreground = Palette.lightBlack | Color.white
    static let background = Palette.bluishwhite | Palette.lightBlack
}
