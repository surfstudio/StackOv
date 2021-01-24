//
//  UserView.swift
//  StackOv
//
//  Created by Erik Basargin
//  Copyright © 2021 Erik Basargin. All rights reserved.
//

import SwiftUI
import Palette

struct UserView: View {
    
    var body: some View {
        HStack(alignment: .center, spacing: 8) {
            Image(systemName: "person.crop.circle.fill")
                .resizable()
                .frame(width: 34, height: 34)
            VStack(alignment: .leading) {
                Text("{Name}")
                    .font(.system(size: 13, weight: .medium))
                    .foregroundColor(Color.nameForeground)
                Text("{email}")
                    .font(.system(size: 10, weight: .regular))
                    .foregroundColor(Color.emailForeground)
            }
        }
        .frame(height: 34)
    }
}

// MARK: - Previews

struct UserView_Previews: PreviewProvider {
    
    static var previews: some View {
        UserView()
            .padding()
            .background(Palette.grayblue)
            .previewLayout(.sizeThatFits)
    }
}

// MARK: - Colors

fileprivate extension Color {
    
    static let nameForeground = Palette.white
    static let emailForeground = Palette.telegrey
}
