//
//  HomeFlow.swift
//  StackOv (HomeFlow module)
//
//  Created by Erik Basargin
//  Copyright © 2021 Erik Basargin. All rights reserved.
//

import SwiftUI
import Palette
import Common
import Introspect
import Components

public struct HomeFlow: View {
    
    // MARK: - Initialization

    public init() {}
    
    // MARK: - View
    
    public var body: some View {
        if UIDevice.current.userInterfaceIdiom.isPad {
            padContent
        } else {
            phoneContent
        }
    }
    
    var phoneContent: some View {
        NavigationView {
            PageView()
                .navigationBarTitle("All Questions")
                .modifier(PhoneNavigationViewIntrospectModifier())
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .accentColor(Color.navigationBarForeground)
    }

    var padContent: some View {
        VStack(spacing: .zero) {
            Divider()
                .background(Color.white.opacity(0.08))
            
            PageView()
        }
    }
}

// MARK: - Previews

struct HomeFlow_Previews: PreviewProvider {
    
    static var previews: some View {
        HomeFlow()
    }
}

// MARK: - View Modifiers

fileprivate struct PhoneNavigationViewIntrospectModifier: ViewModifier {
    
    func body(content: Content) -> some View {
        content.introspectNavigationController {
            $0.view.backgroundColor = UIColor.background
            
            // Hack for changing UIHostViewController with wight background
            $0.children.first?.view.backgroundColor = UIColor.background
        }
    }
}

// MARK: - Colors

fileprivate extension Color {
    
    static let navigationBarForeground = Palette.dullGray
}

fileprivate extension UIColor {
    
    static let background = PaletteCore.bluishblack
}
