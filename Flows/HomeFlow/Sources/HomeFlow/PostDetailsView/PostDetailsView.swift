//
//  PostDetailsView.swift
//  This source file is part of the StackOv open source project
//

import SwiftUI
import Palette
import Common
import Components
import Icons

struct PostDetailsView: View {
    
    // MARK: - States
    
    @State private var title: String = ""
    
    // MARK: - Properties
    
    var defaultSpacing: CGFloat {
        UIDevice.current.userInterfaceIdiom.isPad ? 18 : 12
    }
 
    // MARK: - View
    
    var body: some View {
        ScrollView {
            LazyVStack(spacing: 0) {
                QuestionView()
            }
            .padding(.horizontal, 60)
            .padding(.vertical, defaultSpacing)
        }
        .background(Palette.bluishblack)
        .navigationBarTitle(title, displayMode: .inline)
        .toolbar {
            ToolbarItem(placement: .principal) {
                TextField("Search", text: .constant(""))
                    .padding(.horizontal)
                    .padding(.vertical, 4)
                    .frame(width: 413)
                    .background(Palette.white.opacity(0.08))
                    .cornerRadius(5.0)
            }
            
            ToolbarItemGroup(placement: .navigationBarTrailing) {
                Button(action: {}) {
                    HStack {
                        Text("748")
                            .font(.caption)
                        Image(.bookmark)
                    }
                }.frame(height: 20)
                Button(action: {}, icon: .bell)
                    .frame(width: 20, height: 20)
            }
        }
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
