//
//  SearchView.swift
//  StackOv (HomeFlow module)
//
//  Created by Илья Князьков
//  Copyright © 2021 Erik Basargin. All rights reserved.
//

import SwiftUI
import Palette

struct SearchView: View {

    @Binding var searchText: String

    var body: some View {
            HStack(spacing: 16) {
                searchIcon
                textField
                accessoryButton
            }
            .background(Color.searchBackground)
            .cornerRadius(6)

    }

    var textField: some View {
        TextField("Search", text: $searchText, onCommit: { })
            .foregroundColor(Color.placeHolder)
    }

    var searchIcon: some View {
        Image(systemName: "magnifyingglass")
            .resizable()
            .frame(width: 16, height: 16)
            .foregroundColor(.secondary)
            .padding(.all, 5)
    }

    var accessoryButton: some View {
        Button(action: {
            searchText = ""
        }) {
            accessoryIcon
        }
        .foregroundColor(.secondary)
        .padding(.all, 7)
    }

    var accessoryIcon: some View {
        Image(systemName: "xmark.circle.fill")
            .resizable()
            .frame(width: 16, height: 16)
    }
}

// MARK: - Colors

fileprivate extension Color {

    static let searchBackground = Palette.bluishwhite | Palette.bluishblack
    static let placeHolder = Palette.slateGray | Palette.dullGray
}
