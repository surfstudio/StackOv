//
//  FavoriteFlow.swift
//  StackOv (FavoriteFlow module)
//
//  Created by Evgeny Novgorodov
//  Copyright © 2021 Erik Basargin. All rights reserved.
//

import SwiftUI
import Palette
import Components
import Introspect

public struct FavoriteFlow: View {
    
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
                .navigationBarTitle("Favorite Questions")
                .modifier(PhoneNavigationViewIntrospectModifier())
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .accentColor(Color.navigationBarForeground)
    }
    
    var padContent: some View {
        NavigationView {
            Color.devider
                .ignoresSafeArea(.container, edges: .top)
                .navigationBarHidden(true)
            
            VStack(spacing: .zero) {
                Divider()
                    .background(Color.white.opacity(0.08))
                
                PageView()
                    .background(Color.background)
                    .navigationBarTitle("", displayMode: .inline)
            }
            .modifier(PadNavigationViewIntrospectModifier())
        }
        .navigationViewStyle(DoubleColumnNavigationViewStyle())
        .accentColor(Color.navigationBarForeground)
    }
}

// MARK: - Previews

struct FavoriteFlow_Previews: PreviewProvider {
    static var previews: some View {
        FavoriteFlow()
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

fileprivate struct PadNavigationViewIntrospectModifier: ViewModifier {
    
    func body(content: Content) -> some View {
        content.introspectSplitViewController {
            $0.preferredPrimaryColumnWidth = 1
            $0.minimumPrimaryColumnWidth = 1
            $0.maximumPrimaryColumnWidth = 1
            $0.preferredSplitBehavior = .tile
            $0.preferredDisplayMode = .twoBesideSecondary
            $0.setValue(0, forKey: "gutterWidth") // hide devider between columns
        }
    }
}

// MARK: - Colors

fileprivate extension Color {
    
    static let navigationBarForeground = Palette.slateGrayLight | Palette.dullGray
    static let devider = Palette.lightDivider | Palette.darkDivider
    static let background = Palette.bluishwhite | Palette.bluishblack
}

fileprivate extension UIColor {
    
    static let background = PaletteCore.bluishwhite | PaletteCore.bluishblack
}
