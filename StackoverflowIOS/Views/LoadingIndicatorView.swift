//
//  LoadingIndicatorView.swift
//  StackoverflowIOS
//
//  Created by Erik Basargin on 11/05/2020.
//  Copyright © 2020 Ephedra Software. All rights reserved.
//

import SwiftUI

struct LoadingIndicatorView: View {
    @State private var isAnimating: Bool = false
    
    var body: some View {
        GeometryReader { geometry in
            ForEach(0..<5) { index in
                Group {
                    Circle()
                        .frame(width: geometry.size.width / 5, height: geometry.size.height / 5)
                        .scaleEffect(!self.isAnimating ? 1 - CGFloat(index) / 5 : 0.2 + CGFloat(index) / 5)
                        .offset(y: geometry.size.width / 10 - geometry.size.height / 2)
                }
                .frame(width: geometry.size.width, height: geometry.size.height)
                .rotationEffect(!self.isAnimating ? .degrees(0) : .degrees(360))
                .animation(Animation
                .timingCurve(0.5, 0.15 + Double(index) / 5, 0.25, 1, duration: 1.5)
                 .repeatForever(autoreverses: false))
            }
        }
        .aspectRatio(1, contentMode: .fit)
        .foregroundColor(.foreground)
        .onAppear {
            self.isAnimating = true
        }
    }
}

// MARK: - Previews

#if DEBUG
struct LoadingIndicatorView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            LoadingIndicatorView()
                .frame(width: 30, height: 30)
                .padding()
                .background(Color.mainBackground)
                .previewLayout(.sizeThatFits)
                .environment(\.colorScheme, .light)
            
            LoadingIndicatorView()
                .frame(width: 30, height: 30)
                .padding()
                .background(Color.mainBackground)
                .previewLayout(.sizeThatFits)
                .environment(\.colorScheme, .dark)
        }
    }
}
#endif

fileprivate extension Color {
    static let foreground = Color("loadingIndicatorForeground")
    #if DEBUG
    static let mainBackground = Color("mainBackground")
    #endif
}
