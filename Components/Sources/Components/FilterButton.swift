//
//  FilterButton.swift
//  StackOv (Components module)
//
//  Created by Erik Basargin
//  Copyright © 2021 Erik Basargin. All rights reserved.
//

import SwiftUI
import Palette

public struct FilterButton: View {
    
    @Binding var activeFilters: Int
    private let action: () -> Void
    
    public init(activeFilters: Binding<Int>, action: @escaping () -> Void) {
        self._activeFilters = activeFilters
        self.action = action
    }
    
    public var body: some View {
        Button(action: action) {
            HStack(spacing: 5.38) {
                Text("Filters")
                    .foregroundColor(Color.foreground)
                    .font(.system(size: 11, weight: .medium))
                if activeFilters > 0 {
                    BadgeView(value: $activeFilters)
                        .frame(width: 15, height: 15)
                }
            }
            .padding(EdgeInsets(top: 7.5, leading: 10.31, bottom: 7.5, trailing: 10.31))
        }
        .buttonStyle(FilterButtonStyle())
        .overlay(
            RoundedRectangle(cornerRadius: 8)
                .stroke(Color.border, lineWidth: 0.5)
        )
    }
}

// MARK: - Previews

struct FilterButton_Previews: PreviewProvider {
    
    static var previews: some View {
        FilterButton(activeFilters: .constant(3)) {}
            .padding()
            .background(Color(red: 0.122, green: 0.125, blue: 0.133))
            .previewLayout(.sizeThatFits)
    }
}

// MARK: - Button styles

struct FilterButtonStyle: ButtonStyle {
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .background(Color.background(by: configuration.isPressed))
            .cornerRadius(8)
    }
}

// MARK: - Colors

fileprivate extension Color {
    
    static let foreground = Palette.gainsboro
    static func background(by pressed: Bool) -> Color {
        pressed ? Palette.white.opacity(0.1) : .clear
    }
    static let border = Palette.telegrey
}
