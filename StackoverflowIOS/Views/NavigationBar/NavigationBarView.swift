//
//  NavigationBarView.swift
//  StackoverflowIOS
//
//  Created by Erik Basargin on 10/05/2020.
//  Copyright © 2020 Ephedra Software. All rights reserved.
//

import SwiftUI

struct NavigationBarView: View {
    @EnvironmentObject var stackoverflowStore: StackoverflowStore
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    enum Constants {
        static let height: CGFloat = 44
    }
    
    enum Style {
        case searchBar
        case simpleBar
    }
    
    let style: Style
    
    init(_ style: Style = .simpleBar) {
        self.style = style
    }
    
    var body: some View {
        Group {
            HStack {
                content
            }
            .frame(height: Constants.height)
            .background(Color.background)
            .clipped()
            .shadow(color: .shadow, radius: 10, x: 0, y: 2)
            .padding(.bottom, 20)
        }
        .clipped()
    }
    
    var content: some View {
        switch style {
        case .searchBar:
            return AnyView(searchBar)
        case .simpleBar:
            return AnyView(simpleBar)
        }
    }
    
    var searchBar: some View {
        SearchBarView()
            .padding([.leading, .trailing], 16)
            .environmentObject(self.stackoverflowStore.searchStore)
    }
    
    var simpleBar: some View {
        HStack(spacing: .zero) {
            Spacer()
//            Button(action: { self.presentationMode.wrappedValue.dismiss() }) {
//                Image.back
//                    .resizable()
//                    .frame(width: 12, height: 21)
//            }
//            .frame(width: 32)
//            .background(Color.clear)
//            .foregroundColor(Color.foreground)
//
//            Spacer()
        }
        .frame(height: 33)
        .padding(.horizontal, 6)
    }
}

// MARK: - Previews

#if DEBUG
struct NavigationBarView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            NavigationBarView(.searchBar)
                .padding()
                .previewLayout(.sizeThatFits)
                .background(Color.background)
                .environment(\.colorScheme, .light)
                .environmentObject(StackoverflowStore())
            
            NavigationBarView(.searchBar)
                .padding()
                .previewLayout(.sizeThatFits)
                .background(Color.background)
                .environment(\.colorScheme, .dark)
                .environmentObject(StackoverflowStore())
        }
    }
}
#endif

// MARK: - Extensions

fileprivate extension Image {
    static let back = Image(systemName: "chevron.left")
}

fileprivate extension Color {
    static let foreground = Color("searchBarForeground")
    static let background = Color("mainBackground")
    static let shadow = Color("navigationBarShadow")
}
