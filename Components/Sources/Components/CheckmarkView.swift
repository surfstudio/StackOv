//
//  CheckmarkView.swift
//  This source file is part of the StackOv open source project
//

import SwiftUI
import Palette

public struct CheckmarkView: View {
    
    // MARK: - States
    
    @Binding var isSelected: Bool
    
    // MARK: - Initialization
    
    public init(isSelected: Binding<Bool>) {
        self._isSelected = isSelected
    }
    
    // MARK: - View
    
    public var body: some View {
        if isSelected {
            ZStack {
                circle
                    .overlay(Circle().stroke(Color.foreground(isSelected: true), lineWidth: 1))
                
                Image(systemName: "checkmark")
                    .foregroundColor(Color.white)
            }
        } else {
            circle
                .overlay(Circle().stroke(Color.border, lineWidth: 1))
        }
    }
    
    var circle: some View {
        Circle()
            .frame(width: 20, height: 20)
            .foregroundColor(Color.foreground(isSelected: isSelected))
    }
}

// MARK: - Previews

struct CheckmarkView_Previews: PreviewProvider {
    static var previews: some View {
        CheckmarkView(isSelected: .constant(true))
    }
}

// MARK: - Colors

fileprivate extension Color {
    
    static let border = Palette.telegrey
    
    static func foreground(isSelected: Bool) -> Color {
        isSelected ? Palette.main : Palette.clear
    }
}
