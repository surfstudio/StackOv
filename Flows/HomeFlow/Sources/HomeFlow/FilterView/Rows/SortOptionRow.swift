//
//  SortOptionRow.swift
//  This source file is part of the StackOv open source project
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
            HStack(spacing: 17) {
                Image(systemName: "checkmark")
                    .foregroundColor(Color.checkmarkForegroundColor)
                    .opacity((statesOfSorts[sortOption] ?? false) ? 1 : 0)
                
                Text(sortOption.rawValue)
                    .bold()
            }
        }
        .listRowInsets(EdgeInsets.leading(22))
        .frame(height: 48)
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

// MARK: - Colors

fileprivate extension Color {
        
    static let checkmarkForegroundColor = Palette.main
}
