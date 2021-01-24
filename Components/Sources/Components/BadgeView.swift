//
//  BadgeView.swift
//  StackOv (Components module)
//
//  Created by Erik Basargin
//  Copyright © 2021 Erik Basargin. All rights reserved.
//

import SwiftUI
import Palette

struct BadgeView: View {
    
    @Binding var value: Int
    
    var body: some View {
        GeometryReader { geometry in
            Text("\(value)")
                .font(.system(size: 11, weight: .medium))
                .foregroundColor(Color.foreground)
                .padding(EdgeInsets(top: 0, leading: 3, bottom: 0, trailing: 3))
                .background(Color.background)
                .cornerRadius(geometry.frame(in: .local).height / 2)
        }
    }
}

// MARK: - Previews

struct BadgeView_Previews: PreviewProvider {
    
    static var previews: some View {
        Group {
            BadgeView(value: .constant(3))
                .frame(width: 25, height: 25)
                .padding()
                .previewLayout(.sizeThatFits)
            
            BadgeView(value: .constant(999))
                .frame(height: 25)
                .frame(maxWidth: 30)
                .padding()
                .previewLayout(.sizeThatFits)
            
            BadgeView(value: .constant(999))
                .frame(width: 25, height: 25)
                .padding()
                .previewLayout(.sizeThatFits)
        }
    }
}


// MARK: - Colors

fileprivate extension Color {
    
    static let foreground = Palette.white
    static let background = Palette.main
}
