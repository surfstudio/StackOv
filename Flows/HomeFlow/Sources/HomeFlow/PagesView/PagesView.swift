//
//  PagesView.swift
//  StackOv (HomeFlow module)
//
//  Created by Erik Basargin
//  Copyright © 2021 Erik Basargin. All rights reserved.
//

import SwiftUI
import Palette
import Components

/// This is View to make pages version of the app
///
/// For example, the next code shows how we could use it:
///
///     TabView(selection: $currentPage) {
///         ForEach(pages) { page in
///             PageView().tabItem {
///                 EmptyView()
///             }.tag(page.id)
///         }
///     }
///
struct PagesView: View {
    
    // MARK: - States
    
    @Binding var currentPage: UUID
    
    // MARK: - Properties

    let pages: [PageModel]
    
    // MARK: - View
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(alignment: .center) {
                ForEach(pages) { model in
                    PageButton(model, currentPage: $currentPage)
                }
            }
            .padding(.horizontal, 24)
        }
        .frame(height: 52)
        .background(Color.background)
    }
}

// MARK: - Previews

struct PagesView_Previews: PreviewProvider {
    
    static var previews: some View {
        let id = UUID()
        PagesView(currentPage: .constant(id), pages: [PageModel(id: id, title: "Test Page")])
    }
}

// MARK: - Colors

fileprivate extension UIColor {
    
    static let background = PaletteCore.grayblue.withAlphaComponent(0.5).rgbaToRgb(by: PaletteCore.bluishblack)
}

fileprivate extension Color {
    
    static let background = Color(.background)
}
