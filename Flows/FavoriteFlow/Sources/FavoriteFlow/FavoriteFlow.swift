//
//  FavoriteFlow.swift
//
//
//  Created by Erik Basargin on 08/10/2020.
//

import SwiftUI
import Palette
import Common
import Introspect

public struct FavoriteFlow: View {
    
    let data = (1...50).map { "Item \($0)" }
    
    let columns = [
        GridItem(.adaptive(minimum: 80))
    ]
    
    public init() {}
    
    public var body: some View {
        NavigationView {
            content
                .navigationBarTitle("", displayMode: .inline)
                .modifier(NavigationViewIntrospectModifier())
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
        .navigationViewStyle(StackNavigationViewStyle())
    }
    
    var content: some View {
        List {
            Section(header: Text("Other tasks")) {
                Text("Row 1")
                Text("Row 2")
                LazyVGrid(columns: columns, spacing: 20) {
                    ForEach(data, id: \.self) { item in
                        Text(item)
                    }
                }
                .padding(.horizontal)
            }
        }.introspectTableView {
            $0.backgroundColor = .clear
        }
    }
}

// MARK: - Previews

struct FavoriteFlow_Previews: PreviewProvider {
    static var previews: some View {
        FavoriteFlow()
    }
}

// MARK: - View Modifiers

fileprivate struct NavigationViewIntrospectModifier: ViewModifier {
    func body(content: Content) -> some View {
        content.introspectNavigationController {
            $0.view.backgroundColor = UIColor.background
            $0.navigationBar.setBackgroundImage(UIColor.navigationBackground.image(), for: .default)
            
            $0.navigationBar.tintColor = UIColor.foreground
            
            // Hack for changing UIHostViewController with wight background
            $0.children.first?.view.backgroundColor = .clear
        }
    }
}

// MARK: - Colors

fileprivate extension UIColor {
    static let foreground = PaletteCore.dullGray
    static let background = PaletteCore.bluishblack
    static let navigationBackground = PaletteCore.grayblue.withAlphaComponent(0.5).rgbaToRgb(by: .background)
}
