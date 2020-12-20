//
//  PagesView.swift
//  This source file is part of the StackOv open source project
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

    let pages: [PageModel]
    @Binding var currentPage: UUID
    
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
        PagesView(pages: [PageModel(id: id, title: "Test Page")], currentPage: .constant(id))
    }
}

// MARK: - Colors

fileprivate extension UIColor {
    
    static let background = PaletteCore.grayblue.withAlphaComponent(0.5).rgbaToRgb(by: PaletteCore.bluishblack)
}

fileprivate extension Color {
    
    static let background = Color(.background)
}
