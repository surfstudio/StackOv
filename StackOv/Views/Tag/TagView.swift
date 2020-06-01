//
//  TagView.swift
//  StackOv
//
//  Created by Erik Basargin on 04/05/2020.
//  Copyright © 2020 Ephedra Software. All rights reserved.
//

import Foundation
import SwiftUI

struct TagView: View {
    let tag: String
    let action: () -> Void
    
    init(tag: String, action: @escaping () -> Void) {
        self.tag = tag
        self.action = action
    }
    
    var body: some View {
        Button(action: action) {
            Text(tag)
        }
        .buttonStyle(BorderlessButtonStyle())
        .font(.system(size: 12))
        .lineLimit(1)
        .foregroundColor(.title)
        .padding([.top, .bottom], 4.8)
        .padding([.leading, .trailing], 6)
        .background(Color.background)
        .cornerRadius(3)
    }
}

// MARK: - Previews

#if DEBUG
struct TagView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            TagView(tag: "performance", action: {})
                .padding()
                .previewLayout(.sizeThatFits)
                .environment(\.colorScheme, .light)
            
            TagView(tag: "performance", action: {})
                .padding()
                .previewLayout(.sizeThatFits)
                .environment(\.colorScheme, .dark)
        }
    }
}
#endif

// MARK: - Extensions

fileprivate extension Color {
    static let title = Color("tagTitle")
    static let background = Color("tagBackground")
}
