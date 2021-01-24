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
                .modifier(NavigationViewIntrospectModifier())
        }.navigationViewStyle(StackNavigationViewStyle())
    }

    var padContent: some View {
        VStack(spacing: .zero) {
            Divider()
                .background(Color.white.opacity(0.08))

            sectionHeader
            
            PageView()
        }
    }
    
    var sectionHeader: some View {
        HStack {
            Text("All Questions")
                .textCase(.none)
                .font(.system(size: 22, weight: .bold))
            
            Spacer()
            
            FilterButton(activeFilters: .constant(3), action: { })
        }
        .frame(height: 30)
        .listRowInsets(EdgeInsets.zero)
        .padding(EdgeInsets.all(24))
        .background(Palette.bluishblack)
    }
}

// MARK: - Previews

struct HomeFlow_Previews: PreviewProvider {
    
    static var previews: some View {
        HomeFlow()
    }
}

// MARK: - View Modifiers

fileprivate struct NavigationViewIntrospectModifier: ViewModifier {
    
    func body(content: Content) -> some View {
        content.introspectNavigationController {
            $0.view.backgroundColor = UIColor.background
            $0.navigationBar.tintColor = UIColor.foreground
            
            // Hack for changing UIHostViewController with wight background
            $0.children.first?.view.backgroundColor = UIColor.background
        }
    }
}

// MARK: - Colors

fileprivate extension UIColor {
    
    static let foreground = PaletteCore.dullGray
    static let background = PaletteCore.bluishblack
    static let navigationBackground = PaletteCore.grayblue.withAlphaComponent(0.5).rgbaToRgb(by: .background)
}
