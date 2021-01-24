//
//  PhoneContentView.swift
//  StackOv
//
//  Created by Erik Basargin
//  Copyright © 2021 Erik Basargin. All rights reserved.
//

import SwiftUI
import Palette

struct PhoneContentView: View {

    var body: some View {
        TabView {
            MainBar.tabs
        }
        .accentColor(Palette.white)
    }
}

// MARK: - Previews

struct PhoneContentView_Previews: PreviewProvider {
    
    static var previews: some View {
        PhoneContentView()
    }
}
