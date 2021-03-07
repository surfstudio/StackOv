//
//  PhoneContentView.swift
//  StackOv (MainFlow module)
//
//  Created by Erik Basargin
//  Copyright © 2021 Erik Basargin. All rights reserved.
//

import SwiftUI
import Palette

struct PhoneContentView: View {
    
    // MARK: - View

    var body: some View {
        TabView {
            MainBar.tabs
        }.accentColor(Color.accentColor)
    }
}

// MARK: - Previews

struct PhoneContentView_Previews: PreviewProvider {
    
    static var previews: some View {
        PhoneContentView()
    }
}

// MARK: - Colors

fileprivate extension Color {
    
    static let accentColor = Color.white
}
