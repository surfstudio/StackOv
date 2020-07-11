//
//  EmptyContentView.swift
//  StackOv
//
//  Created by Erik Basargin on 16/05/2020.
//  Copyright © 2020 Ephedra Software. All rights reserved.
//

import SwiftUI

struct EmptyContentView: View {
    var body: some View {
        Image.eyeSlash
            .foregroundColor(Color.foreground)
            .frame(width: 36, height: 36)
    }
}

// MARK: - Previews

#if DEBUG
struct EmptyContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            EmptyContentView()
                .padding()
                .previewLayout(.sizeThatFits)
                .background(Color.mainBackground)
                .environment(\.colorScheme, .light)
            
            EmptyContentView()
                .padding()
                .previewLayout(.sizeThatFits)
                .background(Color.mainBackground)
                .environment(\.colorScheme, .dark)
        }
    }
}
#endif

// MARK: - Extensions

fileprivate extension Image {
    static let eyeSlash = Image(systemName: "eye.slash.fill")
}

fileprivate extension Color {
    static let foreground = Color("loadingIndicatorForeground")
    #if DEBUG
    static let mainBackground = Color("mainBackground")
    #endif
}
