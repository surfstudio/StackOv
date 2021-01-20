//
//  FilterOptionRow.swift
//  
//
//  Created by User on 20.01.2021.
//

import SwiftUI
import Palette

struct FilterOptionRow: View {
    
    @Binding var statesOfFilters: StatesOfFilters
    
    let filterOption: FilterOption
    
    var body: some View {
        
        Button(action: {
            statesOfFilters[filterOption]?.toggle()
        }, label: {
            HStack {
                ZStack {
                    if statesOfFilters[filterOption] ?? false {
                        Circle()
                            .frame(width: 20, height: 20)
                            .foregroundColor(Color.main)
                        Image(systemName: "checkmark")
                            .foregroundColor(Color.white)
                    } else {
                        Circle()
                            .frame(width: 20, height: 20)
                            .foregroundColor(Color.bluishblack)
                            .overlay(Circle().stroke(Color.border, lineWidth: 0.5))
                    }
                }
                .padding(.horizontal, 5)
                
                Text(filterOption.rawValue)
                    .bold()
            }
        })
    }
}

struct FilterOptionRow_Previews: PreviewProvider {
    static var previews: some View {
        FilterOptionRow(statesOfFilters: .constant(StatesOfFilters()), filterOption: .hasBounty)
    }
}

// MARK: - Colors

fileprivate extension Color {
    
    static let bluishblack = Palette.bluishblack
    
    static let main = Palette.main
    
    static let border = Palette.telegrey
}
