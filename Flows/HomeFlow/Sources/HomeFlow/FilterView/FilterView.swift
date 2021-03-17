//
//  FilterView.swift
//  StackOv (HomeFlow module)
//
//  Created by Evgeny Novgorodov
//  Copyright © 2021 Erik Basargin. All rights reserved.
//

import SwiftUI
import Palette
import Introspect
import Combine
import AppScript
import Common

struct FilterView: View {
    
    // MARK: - States
    
    @EnvironmentObject var store: FilterStore
    @Binding var isOpened: Bool
    
    // MARK: - View
    
    var body: some View {
        NavigationView {
            content
                .navigationBarTitle("Filter", displayMode: .inline)
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button(action: { isOpened = false }) {
                            Text("Cancel")
                        }
                    }
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button("Done") {
                            isOpened = false
                            store.saveStates()
                        }
                    }
                }
                .modifier(NavigationViewIntrospectModifier())
        }.accentColor(Color.accentColor)
    }
    
    var content: some View {
        ScrollView {
            VStack(spacing: 0) {
                sectionHeader(title: "Filter by")
                
                ForEach(FilterStore.FilterOption.allCases) {
                    FilterOptionRow(
                        option: $0,
                        filterState: .init(get: { store.filterState }, set: { store.setFilterState(to: $0) } )
                    )
                }
                
                sectionHeader(title: "Sorted by")
                
                ForEach(FilterStore.SortOption.allCases) {
                    SortOptionRow(
                        option: $0,
                        selected: .init(get: { store.sortState }, set: { store.setSortState(to: $0) })
                    )
                }
                
                Spacer()
            }
        }
        .background(Color.background)
        .edgesIgnoringSafeArea(.bottom)
    }
    
    // MARK: - View methods
    
    func sectionHeader(title: String) -> some View {
        VStack {
            HStack {
                Text(title.uppercased())
                    .font(.body)
                    .foregroundColor(Color.sectionForeground)
                    .padding(EdgeInsets(top: 24, leading: 20, bottom: 10, trailing: 0))
                
                Spacer()
            }
        }
    }
}

// MARK: - Previews

struct FilterView_Previews: PreviewProvider {
    
    static var previews: some View {
        FilterView(isOpened: .constant(true))
    }
}

// MARK: - View modifiers

fileprivate struct NavigationViewIntrospectModifier: ViewModifier {
    
    func body(content: Content) -> some View {
        content.introspectNavigationController {
            $0.navigationBar.backgroundColor = UIColor.navigationBackground
            $0.navigationBar.barTintColor = UIColor.navigationBackground
            
            // This is hack to make navigation bar clear
            let image = UIImage()
            $0.navigationBar.shadowImage = image
            $0.navigationBar.setBackgroundImage(image, for: .default)
        }
    }
}

// MARK: - Colors

fileprivate extension Color {
    
    static let accentColor = Palette.main
    static let sectionForeground = Palette.slateGrayLight | Palette.dullGray
    static let background = Palette.lightGray | Palette.bluishblack
}

fileprivate extension UIColor {
    
    static let navigationBackground = PaletteCore.bluishwhite | PaletteCore.lightBlack
}
