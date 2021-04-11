//
//  CompactUserView.swift
//  StackOv (MainFlow module)
//
//  Created by Владислав Климов
//  Copyright © 2021 Erik Basargin. All rights reserved.
//

import SwiftUI
import Palette

struct CompactUserView: View {

    var body: some View {
        Image(systemName: "person.crop.circle.fill")
            .resizable()
            .frame(width: 34, height: 34)
    }
}

// MARK: - Previews

struct CompactUserView_Previews: PreviewProvider {
    
    static var previews: some View {
        CompactUserView()
    }
}
