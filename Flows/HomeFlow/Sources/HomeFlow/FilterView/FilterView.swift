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

struct FilterView: View {
    
    // MARK: - States
    
    // TODO: Issue #28; This is mock logic
    @State var statesOfFilters: [FilterOption: Bool] = {
        var states = [FilterOption: Bool]()
        FilterOption.allCases.forEach { states[$0] = Bool.random() }
        return states
    }()
    
    @State var statesOfSorts: [SortOption: Bool] = {
        var states = [SortOption: Bool]()
        SortOption.allCases.forEach { states[$0] = false }
        return states
    }()
    
    // MARK: - Properties
    
    let onCancel: () -> Void
    let onDone: () -> Void
    
    // MARK: - Initialization
    
    init(onCancel: @escaping () -> Void, onDone: @escaping () -> Void) {
        self.onCancel = onCancel
        self.onDone = onDone
    }
    
    // MARK: - View
    
    var body: some View {
        NavigationView {
            content
                .navigationBarTitle("Filter", displayMode: .inline)
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button(action: onCancel) {
                            Text("Cancel")
                        }
                    }
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button(action: onDone) {
                            Text("Done")
                        }
                    }
                }
                .modifier(NavigationViewIntrospectModifier())
        }
    }
    
    var content: some View {
        ScrollView {
            LazyVStack(spacing: 0) {
                sectionHeader(title: "Filter by")
                
                ForEach(FilterOption.allCases) {
                    FilterOptionRow(statesOfFilters: $statesOfFilters, filterOption: $0)
                }
                
                sectionHeader(title: "Sorted by")
                
                ForEach(SortOption.allCases) {
                    SortOptionRow(statesOfSorts: $statesOfSorts, sortOption: $0)
                }
                
                Spacer()
            }
        }
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
        .background(Color.sectionBackground)
    }
}

// MARK: - Previews

struct FilterView_Previews: PreviewProvider {
    
    static var previews: some View {
        FilterView(onCancel: {}, onDone: {})
    }
}

// MARK: - View modifiers

fileprivate struct NavigationViewIntrospectModifier: ViewModifier {
    
    func body(content: Content) -> some View {
        content.introspectNavigationController {
            $0.navigationBar.backgroundColor = UIColor.navigationBackground
            $0.navigationBar.tintColor = UIColor.main
            
            // This is hack to make navigation bar clear
            let image = UIImage()
            $0.navigationBar.shadowImage = image
            $0.navigationBar.setBackgroundImage(image, for: .default)
        }
    }
}

// MARK: - Colors

fileprivate extension Color {
    
    static let background = Palette.bluishblack
    static let sectionForeground = Palette.dullGray
    static let sectionBackground = Palette.bluishblack
    static let dividerBackground = Palette.grayblue
}

fileprivate extension UIColor {
    
    static let foreground = PaletteCore.dullGray
    static let background = PaletteCore.bluishblack
    static let rowBackground = PaletteCore.grayblue
        .withAlphaComponent(0.7).rgbaToRgb(by: .background)
    static let navigationBackground = PaletteCore.grayblue
        .withAlphaComponent(0.7).rgbaToRgb(by: .background)
}
