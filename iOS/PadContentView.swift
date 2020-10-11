//
//  PadContentView.swift
//  StackOv (iOS)
//
//  Created by Erik Basargin on 07/10/2020.
//

import SwiftUI
import Palette
import Introspect

import HomeFlow
import FavoriteFlow
import MessagesFlow
import TagsFlow
import UsersFlow

struct PadContentView: View {
    
    @State private var state: MainBarItemType = .home
    
    var body: some View {
        NavigationView {
            SidebarView(state: $state)
                .padding(EdgeInsets(top: 20, leading: 10, bottom: 20, trailing: 10))
                .navigationBarTitle("", displayMode: .inline)
                .modifier(SidebarViewIntrospectModifier())
            
            MainView(state: $state)
                .navigationBarTitle("", displayMode: .inline)
                .navigationBarHidden(true)
                .modifier(MainViewIntrospectModifier())
        }
        .navigationViewStyle(DoubleColumnNavigationViewStyle())
    }
}

fileprivate struct MainView: View {
    
    @Binding var state: MainBarItemType
    
    var body: some View {
        TabView(selection: $state) {
            HomeFlow()
                .modifier(TabModifier(item: .home))
            
            FavoriteFlow()
                .modifier(TabModifier(item: .favorite))
            
            MessagesFlow()
                .modifier(TabModifier(item: .messages))
            
            TagsFlow()
                .modifier(TabModifier(item: .tags))
            
            UsersFlow()
                .modifier(TabModifier(item: .users))
        }
        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
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
            $0.setNavigationBarHidden(true, animated: false)
            
            // Hack for changing UIHostViewController with wight background
            $0.children.first?.view.backgroundColor = UIColor.Sidebar.backgound
        }
        .introspectSplitViewController {
            $0.minimumPrimaryColumnWidth = 210
            $0.maximumPrimaryColumnWidth = 210
            $0.preferredSplitBehavior = .tile
            
            // Hack for changing tint color of the displayModeButtonItem
            $0.view.tintColor = UIColor.Sidebar.foreground
        }
    }
}

fileprivate struct MainViewIntrospectModifier: ViewModifier {
    
    func body(content: Content) -> some View {
        content.introspectNavigationController {
            // Hack for changing UIHostViewController with wight background
            $0.children.first?.view.backgroundColor = UIColor.MainView.globalBackground
        }
    }
}

fileprivate struct TabModifier: ViewModifier {
    
    let item: MainBarItemType
    
    func body(content: Content) -> some View {
        content.tabItem {
            Image(systemName: item.image)
            Text(item.title)
        }.tag(item)
    }
}

// MARK: - Colors

fileprivate extension UIColor {
    
    enum Sidebar {
        static let backgound = PaletteCore.grayblue
        static let foreground = PaletteCore.dullGray
    }
    
    enum MainView {
        static let background = PaletteCore.bluishblack
        static let globalBackground = PaletteCore.grayblue.withAlphaComponent(0.5).rgbaToRgb(by: Self.background)
    }
}
