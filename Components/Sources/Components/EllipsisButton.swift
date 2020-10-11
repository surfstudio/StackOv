//
//  EllipsisButton.swift
//  
//
//  Created by Erik Basargin on 09/10/2020.
//

import SwiftUI
import Palette

public struct EllipsisButton: View {
    
    let action: () -> Void
    
    public init(action: @escaping () -> Void) {
        self.action = action
    }
    
    public var body: some View {
        Button(action: action) {
            Image(systemName: "ellipsis")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 18, height: 18)
        }
        .frame(width: 24, height: 24)
        .foregroundColor(Color.foreground)
        .clipShape(Circle())
        .buttonStyle(EllipsisButtonStyle())
    }
}

// MARK: - Previews

struct EllipsisButton_Previews: PreviewProvider {
    
    static var previews: some View {
        EllipsisButton(action: {})
            .padding()
            .previewLayout(.sizeThatFits)
            .background(Color(red: 0.276, green: 0.122, blue: 0.438))
    }
}

// MARK: - Button styles

struct EllipsisButtonStyle: ButtonStyle {
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(width: 24, height: 24)
            .background(Color.background(by: configuration.isPressed))
    }
}

// MARK: - Colors

fileprivate extension Color {
    
    static let foreground = Palette.white
    static func background(by pressed: Bool) -> Color {
        Palette.white.opacity(pressed ? 0.2 : 0.1)
    }
}
