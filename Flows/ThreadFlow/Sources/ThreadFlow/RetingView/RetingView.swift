//
//  RetingView.swift
//  StackOv (ThreadFlow module)
//
//  Created by Владислав Климов
//  Copyright © 2021 Erik Basargin. All rights reserved.
//

import SwiftUI
import Palette

struct RetingView: View {
    
    // MARK: - Properties
    
    var viewed: String
    
    // MARK: - Views
    
    var body: some View {
        VStack(alignment: .center, spacing: 8) {
            Button(action: {}, icon: .handThumbsupFill)
                .frame(width: 24, height: 24)
                .foregroundColor(Palette.slateGray | Palette.dullGray)
            Text(viewed)
                .font(.footnote)
                .foregroundColor(Palette.slateGray | Palette.dullGray)
            Button(action: {}, icon: .handThumbsdownFill)
                .frame(width: 24, height: 24)
                .foregroundColor(Palette.slateGray | Palette.dullGray)
        }
    }
}

struct RetingView_Previews: PreviewProvider {
    static var previews: some View {
        RetingView(viewed: "365")
    }
}
