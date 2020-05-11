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
    
    enum Constants {
        static let height: CGFloat = 47
    }
    
    var body: some View {
        Group {
            HStack {
                SearchBarView()
                    .padding([.leading, .trailing], 16)
                    .environmentObject(self.stackoverflowStore.searchStore)
            }
            .frame(height: Constants.height)
            .background(Color.background)
            .clipped()
            .shadow(color: .shadow, radius: 4, x: 0, y: 2)
            .padding(.bottom, 10)
        }
        .clipped()
    }
}

// MARK: - Previews

#if DEBUG
struct NavigationBarView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            NavigationBarView()
                .padding()
                .previewLayout(.sizeThatFits)
                .background(Color.background)
                .environment(\.colorScheme, .light)
            
            NavigationBarView()
                .padding()
                .previewLayout(.sizeThatFits)
                .background(Color.background)
                .environment(\.colorScheme, .dark)
        }
    }
}
#endif

// MARK: - Extensions

fileprivate extension Color {
    static let background = Color("mainBackground")
    static let shadow = Color("navigationBarShadow")
}
