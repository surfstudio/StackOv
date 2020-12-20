//
//  PadContentView.swift
//  This source file is part of the StackOv open source project
//

import SwiftUI
import Palette
import Introspect

struct PadContentView: View {
    
    @State private var state: MainBar.ItemType = .home
    
    var body: some View {
        NavigationView {
            SidebarView(state: $state)
                .padding(EdgeInsets(top: 20, leading: 10, bottom: 20, trailing: 10))
                .navigationBarTitle("", displayMode: .inline)
                .modifier(SidebarViewIntrospectModifier())

            MainView(state: $state)
                .navigationBarTitle("", displayMode: .inline)
                .modifier(MainViewIntrospectModifier())
                .toolbar {
                    ToolbarItem(placement: .principal) {
                        TextField("Search", text: .constant(""))
                            .padding(.horizontal)
                            .padding(.vertical, 4)
                            .frame(width: 413)
                            .background(Palette.white.opacity(0.08))
                            .cornerRadius(5.0)
                    }
                }
        }
        .navigationViewStyle(DoubleColumnNavigationViewStyle())
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
