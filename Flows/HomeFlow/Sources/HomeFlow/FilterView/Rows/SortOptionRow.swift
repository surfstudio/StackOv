//
//  SortOptionRow.swift
//  StackOv (HomeFlow module)
//
//  Created by Evgeny Novgorodov
//  Copyright © 2021 Erik Basargin. All rights reserved.
//

import SwiftUI
import Palette

struct SortOptionRow: View {
    
    // MARK: - States
    
    @Binding var statesOfSorts: [SortOption: Bool]
    
    // MARK: - Properties
    
    let sortOption: SortOption
    
    // MARK: - View
    
    var body: some View {
        Button(action: {
            // TODO: Issue #28; This logic should be the store
            statesOfSorts = reset(states: statesOfSorts)
            statesOfSorts[sortOption]?.toggle()
        }) {
            VStack(alignment: .leading, spacing: 0) {
                Spacer()
                
                HStack(spacing: 17) {
                    Image(systemName: "checkmark")
                        .frame(width: 20, height: 20)
                        .foregroundColor(Color.checkmarkForeground)
                        .opacity((statesOfSorts[sortOption] ?? false) ? 1 : 0)
                    
                    Text(sortOption.rawValue)
                        .bold()
                        .foregroundColor(Color.foreground)
                }
                
                Spacer()
                
                Divider()
                    .padding(.leading, sortOption.isLast ? -22 : 38)
            }
            .padding(.leading, 22)
        }
        .frame(minHeight: 48)
        .background(Color.background)
    }
            
    // MARK: - Methods
    
    func reset(states: [SortOption: Bool]) -> [SortOption: Bool] {
        states.mapValues { _ in false }
    }
}

// MARK: - Previews

struct SortOptionRow_Previews: PreviewProvider {
    
    static var previews: some View {
        SortOptionRow(statesOfSorts: .constant(.init()), sortOption: .newest)
    }
}

// MARK: - Estensions

fileprivate extension SortOption {
    
    var isLast: Bool {
        self == Self.allCases.last
    }
}

// MARK: - Colors

fileprivate extension Color {
    
    static let foreground = Palette.white
    static let background = Palette.grayblue
    static let checkmarkForeground = Palette.main
}
