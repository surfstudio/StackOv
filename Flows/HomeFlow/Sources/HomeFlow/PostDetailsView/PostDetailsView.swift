//
//  PostDetailsView.swift
//  This source file is part of the StackOv open source project
//

import SwiftUI
import Palette
import Common

struct PostDetailsView: View {
 
    // MARK: - View
    
    var body: some View {
        Text("PostDetailsView")
    }
}

// MARK: - Previews

struct PostDetailsView_Previews: PreviewProvider {
    
    static var previews: some View {
        PostDetailsView()
    }
}

// MARK: - Colors

fileprivate extension UIColor {
    
    static let foreground = PaletteCore.dullGray
    static let background = PaletteCore.bluishblack
    static let navigationBackground = PaletteCore.grayblue.withAlphaComponent(0.5).rgbaToRgb(by: .background)
}
