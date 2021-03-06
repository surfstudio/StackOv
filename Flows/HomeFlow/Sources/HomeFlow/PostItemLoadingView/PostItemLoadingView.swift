//
//  PostItemLoadingView.swift
//  StackOv (HomeFlow module)
//
//  Created by Влад Климов
//  Copyright © 2021 Erik Basargin. All rights reserved.
//

import SwiftUI
import Palette
import Components

struct PostItemLoadingView: View {

    // MARK: - Constants
    
    private enum Constants {
        static let minWidth: CGFloat = 267
        static let minHeight: CGFloat = 223
    }
    
    // MARK: - States
    
    @Environment(\.colorScheme) var colorScheme
    @EnvironmentObject var shimmerConfig: ShimmerConfig

    // MARK: - Properties
        
    let shimmerIsActive: Bool
    
    // MARK: - Views
    
    var body: some View {
        Rectangle()
            .shimmer(isActive: shimmerIsActive)
            .environmentObject(shimmerConfig)
            .mask(items)
            .foregroundColor(Color.itemsColor)
            .background(Color.background)
            .frame(minWidth: Constants.minWidth, maxWidth: .infinity, minHeight: Constants.minHeight, alignment: .leading)
            .cornerRadius(20)
    }
    
    var items: some View {
        VStack(alignment: .leading, spacing: 20) {
            topItems
            bottomItems
            Spacer()
            Rectangle()
                .foregroundColor(Color.black)
                .cornerRadius(12)
                .frame(width: 80, height: 10)
        }
        .padding(EdgeInsets.all(16))
        .frame(minWidth: Constants.minWidth, maxWidth: .infinity, minHeight: Constants.minHeight, alignment: .leading)
    }
    
    var topItems: some View {
        HStack(alignment: .center, spacing: 20) {
            Rectangle()
                .foregroundColor(Color.black)
                .cornerRadius(10)
                .frame(width: 52, height: 41)
            Rectangle()
                .foregroundColor(Color.black)
                .cornerRadius(12)
                .frame(width: 48, height: 10)
        }
    }
    
    var bottomItems: some View {
        VStack(alignment: .leading, spacing: 10) {
            Rectangle()
                .foregroundColor(Color.black)
                .cornerRadius(12)
                .frame(width: 219, height: 10)
            Rectangle()
                .foregroundColor(Color.black)
                .cornerRadius(12)
                .frame(width: 92, height: 10)
            Rectangle()
                .foregroundColor(Color.black)
                .cornerRadius(12)
                .frame(width: 143, height: 10)
        }
    }
    
}

// MARK: - Previews

struct SwiftUIView_Previews: PreviewProvider {
    
    static var previews: some View {
        PostItemLoadingView(shimmerIsActive: true)
            .environmentObject(ShimmerConfig(bgColor: .clear, fgColor: .clear))
    }
}


// MARK: - Colors

fileprivate extension Color {

    static let itemsColor = Color(red: 0.873, green: 0.873, blue: 0.892) | Color(red: 0.231, green: 0.235, blue: 0.255)
    static let background = Palette.periwinkleCrayola | Palette.grayblue

}
