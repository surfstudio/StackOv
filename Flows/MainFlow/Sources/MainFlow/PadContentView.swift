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
import SidebarStore
import AppScript

struct PadContentView: View {
    
    // MARK: - States
    
    @Environment(\.horizontalSizeClass) public var horizontalSizeClass
    @State private var state: MainBar.ItemType = .home
    @Store private var store: SidebarStore
    
    // MARK: - Initialization
    
    init() {
        configureGlobalNavigationBar()
    }
    
    // MARK: - View
    
    var body: some View {
        HStack(spacing: .zero) {
            sidebar()
            ZStack {
                HStack(spacing: 0) {
                    Color.Sidebar.devider.frame(width: 1)
                    Color.MainView.navigationBarBackground
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
        .background(Color.background)
    }
    
    var regularSidebar: some View {
        SidebarView(state: $state)
            .padding(EdgeInsets(top: 20, leading: 10, bottom: 20, trailing: 10))
            .background(Color.Sidebar.backgound)
            .frame(maxWidth: 210)
            .ignoresSafeArea(.container, edges: .top)
    }
    
    var compactSideBar: some View {
        EmptyView()
    }
    
    // MARK: - View Methods
    
    private func sidebar() -> some View {
        switch horizontalSizeClass {
        case .regular:
            store.changeShow(true)
        case .compact:
            store.changeShow(false)
        default:
            store.changeShow(false)
        }
        
        return sidebarView()
    }
    
    @ViewBuilder private func sidebarView() -> some View {
        if (store.isShow) {
            regularSidebar
        } else {
            compactSideBar
        }
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
    
    static let background = Palette.lightGray | Palette.lightBlack
    
    enum Sidebar {
        static let devider = Palette.lightDivider | Palette.darkDivider
        static let backgound = Palette.periwinkleCrayola | Palette.grayblue
    }
    
    enum MainView {
        static let navigationBarBackground = Palette.lightGray | Palette.lightBlack
    }
}

fileprivate extension UIColor {
    
    enum MainView {
        static let foreground = PaletteCore.slateGrayLight | PaletteCore.dullGray
        static let navigationBarBackground =  PaletteCore.lightGray | PaletteCore.lightBlack
    }
}
