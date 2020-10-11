//
//  HomeFlow.swift
//  
//
//  Created by Erik Basargin on 08/10/2020.
//

import SwiftUI
import Palette
import Common
import Introspect
import Components

public struct HomeFlow: View {
    
    let data = [
        (Color(red: 0.471, green: 0.238, blue: 0.704),
         Color(red: 0.276, green: 0.122, blue: 0.438)),
        (Color(red: 0.348, green: 0.222, blue: 0.762),
         Color(red: 0.181, green: 0.119, blue: 0.375)),
        (Color(red: 0.115, green: 0.408, blue: 0.725),
         Color(red: 0.069, green: 0.221, blue: 0.504)),
        (Color(red: 0.121, green: 0.257, blue: 0.529),
         Color(red: 0.062, green: 0.167, blue: 0.375)),
        (Color(red: 0.264, green: 0.55, blue: 0.43),
         Color(red: 0.083, green: 0.321, blue: 0.221)),
        (Color(red: 0.113, green: 0.425, blue: 0.406).opacity(0.85),
         Color(red: 0.053, green: 0.325, blue: 0.309)),
        (Color(red: 0.479, green: 0.14, blue: 0.282).opacity(0.85),
         Color(red: 0.387, green: 0.137, blue: 0.377)),
        (Color(red: 0.127, green: 0.276, blue: 0.308).opacity(0.85),
         Color(red: 0.091, green: 0.222, blue: 0.317)),
        (Color(red: 0.517, green: 0.324, blue: 0.282).opacity(0.86),
         Color(red: 0.254, green: 0.166, blue: 0.116)),
        (Color(red: 0.216, green: 0.394, blue: 0.558).opacity(0.85),
         Color(red: 0.097, green: 0.139, blue: 0.225)),
        (Color(red: 0.181, green: 0.222, blue: 0.304).opacity(0.85),
         Color(red: 0.098, green: 0.143, blue: 0.233)),
        (Color(red: 0.189, green: 0.111, blue: 0.287).opacity(0.85),
         Color(red: 0.164, green: 0.145, blue: 0.375))
    ].map { QuestionItemView.Model(colors: $0) }
    
    let columns = [
        GridItem(.adaptive(minimum: 267), spacing: 24)
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
            Section(header: header) {
//                Text("Tags...") // Might be need to move to the header
//                    .frame(height: 23)
//                    .listRowInsets(EdgeInsets(top: 0, leading: 24, bottom: 32, trailing: 24))
//                    .introspectTableViewCell {
//                        $0.backgroundColor = .clear
//                    }
                
                LazyVGrid(columns: columns, spacing: 24) {
                    ForEach(data) { item in
                        QuestionItemView(item)
                    }
                }
                .listRowInsets(.zero)
                .padding(EdgeInsets(top: 24, leading: 24, bottom: 24, trailing: 24))
                .background(Palette.bluishblack)
            }
        }
        .introspectTableView {
            $0.backgroundColor = .clear
        }
    }
    
    var header: some View {
        HStack {
            Text("All Questions")
                .textCase(.none)
                .font(.system(size: 22, weight: .bold))
            
            Spacer()
            
            FilterButton(activeFilters: .constant(3), action: {})
                .textCase(.none)
        }
        .frame(height: 30)
        .listRowInsets(EdgeInsets.zero)
        .padding(EdgeInsets(top: 24, leading: 24, bottom: 22, trailing: 24))
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
