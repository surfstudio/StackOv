//
//  SortOptionRow.swift
//  
//
//  Created by User on 20.01.2021.
//

import SwiftUI
import Palette

struct SortOptionRow: View {
    
    @Binding var statesOfSorts: StatesOfSorts
    
    let sortOption: SortOption
    
    var body: some View {
        Button(action: {
            statesOfSorts.reset()
            statesOfSorts[sortOption]?.toggle()
        }, label: {
            HStack {
                if statesOfSorts[sortOption] ?? false {
                    Image(systemName: "checkmark")
                        .foregroundColor(Color.main)
                        .padding(.horizontal, 5)
                } else {
                    Image(systemName: "checkmark")
                        .foregroundColor(Color.bluishblack)
                        .padding(.horizontal, 5)
                }
                
                Text(sortOption.rawValue)
                    .bold()
            }
        })
    }
}

struct SortOptionRow_Previews: PreviewProvider {
    static var previews: some View {
        SortOptionRow(statesOfSorts: .constant(StatesOfSorts()), sortOption: .newest)
    }
}

// MARK: - Colors

fileprivate extension Color {
    
    static let bluishblack = Palette.bluishblack
    
    static let main = Palette.main
}
