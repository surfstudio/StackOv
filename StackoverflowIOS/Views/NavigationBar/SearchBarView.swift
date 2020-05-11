//
//  SearchBarView.swift
//  StackoverflowIOS
//
//  Created by Erik Basargin on 10/05/2020.
//  Copyright © 2020 Ephedra Software. All rights reserved.
//

import SwiftUI
 
struct SearchBarView: View {
    @EnvironmentObject var searchStore: SearchStore
 
    var body: some View {
        HStack(spacing: .zero) {
            searchIcon
            textField
            if self.searchStore.isEditing {
                accessoryButton
            }
        }
        .frame(height: 33)
    }
    
    var searchIcon: some View {
        Group {
            Image.magnifier
                .resizable()
                .frame(width: 21, height: 21)
        }
        .frame(width: 32)
        .background(Color.clear)
        .foregroundColor(Color.foreground)
    }
    
    var textField: some View {
        TextField("Search...", text: self.$searchStore.query)
            .foregroundColor(Color.foreground)
            .font(.system(size: 13))
            .background(Color.clear)
            .onTapGesture {
                self.searchStore.startEditing()
            }
    }
    
    var accessoryButton: some View {
        Button(action: { self.searchStore.clean() }) {
            Image.xmark
                .resizable()
                .frame(width: 16, height: 16)
        }
        .foregroundColor(Color(.systemGray3))
        .padding(.all, 10)
        .transition(.opacity)
        .animation(.default)
    }
}

// MARK: - Previews

#if DEBUG
struct SearchBarView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            SearchBarView()
                .padding()
                .previewLayout(.sizeThatFits)
                .background(Color.mainBackground)
                .environment(\.colorScheme, .light)
            
            SearchBarView()
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
    static let magnifier = Image(systemName: "magnifyingglass")
    static let xmark = Image(systemName: "xmark.circle.fill")
}

fileprivate extension Color {
    static let foreground = Color("searchBarForeground")
    static let background = Color("searchBarBackground")
    #if DEBUG
    static let mainBackground = Color("mainBackground")
    #endif
}
