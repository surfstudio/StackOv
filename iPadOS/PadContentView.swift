//
//  PadContentView.swift
//  StackOv
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
        NavigationView {
            SidebarView(state: $state)
                .padding(EdgeInsets(top: 20, leading: 10, bottom: 20, trailing: 10))
                .navigationBarTitle("", displayMode: .inline)
                .modifier(SidebarViewIntrospectModifier())
                .navigationBarHidden(true)
                .background(Color.Sidebar.backgound)

            MainView(state: $state)
                .navigationBarTitle("", displayMode: .inline)
                .background(Color.MainView.background)
                .toolbar {
                    #if DEBUG
                    ToolbarItem(placement: .principal) {
                        TextField("Search", text: .constant(""))
                            .padding(.horizontal)
                            .padding(.vertical, 4)
                            .frame(width: 413)
                            .background(Palette.white.opacity(0.08))
                            .cornerRadius(5.0)
                    }
                    #endif
                }
        }
        .navigationViewStyle(DoubleColumnNavigationViewStyle())
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

// MARK: - View Modifiers

fileprivate struct SidebarViewIntrospectModifier: ViewModifier {
    
    func body(content: Content) -> some View {
        content.introspectNavigationController {
            // Hack for changing UIStatusBar background
            $0.children.first?.view.backgroundColor = UIColor.Sidebar.backgound
        }.introspectSplitViewController {
            $0.preferredPrimaryColumnWidth = 210
            $0.minimumPrimaryColumnWidth = 210
            $0.maximumPrimaryColumnWidth = 210
            $0.preferredSplitBehavior = .tile
            
            // Hack for changing tint color of the displayModeButtonItem
            // because UINavigationBar.appearance().tintColor = PaletteCore.dullGray works not correct with displayModeButtonItem
            $0.view.tintColor = UIColor.Sidebar.foreground
        }
    }
}

// MARK: - Colors

fileprivate extension Color {
    
    enum Sidebar {
        static let backgound = Palette.grayblue
    }
    
    enum MainView {
        static let background = Palette.bluishblack
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
