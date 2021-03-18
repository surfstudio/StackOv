//
//  [NAME].swift
//  StackOv ([NAME] module)
//
//  Created by Влад Климов
//  Copyright © 2021 Erik Basargin. All rights reserved.
//

import SwiftUI
import Palette

struct PostItemLoadingView: View {

    // MARK: - States
    
    @Environment(\.colorScheme) var colorScheme

    // MARK: - Properties
        
    let lightItemColor = Color(red: 0.873, green: 0.873, blue: 0.892)
    let darkItemColor = Color(red: 0.231, green: 0.235, blue: 0.255)
    
    // MARK: - Views
    
    var body: some View {
        items
            .frame(minWidth: 267, maxWidth: .infinity, minHeight: 223, alignment: .leading)
            .background(colorScheme == .dark ? Palette.grayblue : Palette.periwinkleCrayola)
            .cornerRadius(20)
    }
    
    var items: some View {
        VStack(alignment: .leading, spacing: 20) {
            topItems
            centerItems
            Spacer()
            Rectangle()
                .foregroundColor(itemColor())
                .cornerRadius(12)
                .frame(width: 80, height: 10)
        }
        .padding(EdgeInsets.all(16))
    }
    
    var topItems: some View {
        HStack(alignment: .center, spacing: 20) {
            Rectangle()
                .foregroundColor(itemColor())
                .cornerRadius(10)
                .frame(width: 52, height: 41)
            Rectangle()
                .foregroundColor(itemColor())
                .cornerRadius(12)
                .frame(width: 48, height: 10)
        }
    }
    
    var centerItems: some View {
        VStack(alignment: .leading, spacing: 10) {
            Rectangle()
                .foregroundColor(itemColor())
                .cornerRadius(12)
                .frame(width: 219, height: 10)
            Rectangle()
                .foregroundColor(itemColor())
                .cornerRadius(12)
                .frame(width: 92, height: 10)
            Rectangle()
                .foregroundColor(itemColor())
                .cornerRadius(12)
                .frame(width: 143, height: 10)
        }
    }
    
    // MARK: - View methods
    
    func itemColor() -> Color {
        colorScheme == .dark ? darkItemColor : lightItemColor
    }
    
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        PostItemLoadingView()
    }
}
