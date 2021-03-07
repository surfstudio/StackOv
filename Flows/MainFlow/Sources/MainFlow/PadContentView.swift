//
//  PadContentView.swift
//  StackOv (MainFlow module)
//
//  Created by Erik Basargin
//  Copyright © 2021 Erik Basargin. All rights reserved.
//

import SwiftUI
import Palette
import Introspect

struct PadContentView: View {
    
    // MARK: - States
    
    @State private var state: MainBar.ItemType = .home
    
    // MARK: - Initialization
    
    init() {
        configureGlobalNavigationBar()
    }
    
    // MARK: - View
    
    var body: some View {
        HStack(spacing: .zero) {
            SidebarView(state: $state)
                .padding(EdgeInsets(top: 20, leading: 10, bottom: 20, trailing: 10))
                .background(Color.Sidebar.backgound)
                .frame(maxWidth: 210)
                .ignoresSafeArea(.container, edges: .top)

            ZStack {
                HStack(spacing: 0) {
                    Color.Sidebar.devider.frame(width: 1)
                    Color.MainView.background
                }
                .ignoresSafeArea(.container, edges: .top)
                .frame(
                    minWidth: 0,
                    maxWidth: .infinity,
                    minHeight: 0,
                    maxHeight: .infinity,
                    alignment: .topLeading
                )
                
                MainView(state: $state)
            }
        }
        .background(Color.MainView.background)
    }
    
    // MARK: - Methods
    
    func configureGlobalNavigationBar() {
        let coloredAppearance = UINavigationBarAppearance()
        coloredAppearance.configureWithTransparentBackground()
        coloredAppearance.backgroundColor = UIColor.MainView.navigationBarBackground
        coloredAppearance.titleTextAttributes = [.foregroundColor: UIColor.MainView.foreground]
        coloredAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.MainView.foreground]
        
        UINavigationBar.appearance().standardAppearance = coloredAppearance
        UINavigationBar.appearance().compactAppearance = coloredAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = coloredAppearance
    }
}

fileprivate struct MainView: View {
    
    @Binding var state: MainBar.ItemType
    
    var body: some View {
        TabView(selection: $state) {
            MainBar.tabs
        }
        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
        .introspectScrollView {
            $0.isScrollEnabled = false
            // Hack to disable scrolling of current TabView
            for subview in $0.subviews {
                (subview as? UIScrollView)?.isScrollEnabled = false
            }
        }
    }
}

// MARK: - Previews

struct PadContentView_Previews: PreviewProvider {
    
    static var previews: some View {
        PadContentView()
    }
}

// MARK: - Colors

fileprivate extension Color {
    
    enum Sidebar {
        static let devider = Palette.bluishblack
        static let backgound = Palette.grayblue
    }
    
    enum MainView {
        static let background = Color(UIColor.MainView.navigationBarBackground)
    }
}

fileprivate extension UIColor {
    
    enum Sidebar {
        static let backgound = PaletteCore.grayblue
        static let foreground = PaletteCore.dullGray
    }
    
    enum MainView {
        static let foreground = PaletteCore.dullGray
        static let background = PaletteCore.bluishblack
        static let navigationBarBackground = PaletteCore.grayblue.withAlphaComponent(0.5).rgbaToRgb(by: Self.background)
    }
}
