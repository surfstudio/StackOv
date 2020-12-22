//
//  PageView.swift
//  This source file is part of the StackOv open source project
//

import SwiftUI
import Palette
import Common
import Introspect
import Components

struct PageView: View {
    
    // FIXIT: - Need to replace this to mock service
    let data = Palette.linearGradientPalette.map {
        QuestionItemModel(
            id: UUID(),
            title: "How to make TouchableOpacity wrap its content when nested inside parent that has flex = 1",
            isApproved: false,
            answersNumber: 3,
            votesNumber: 15,
            viewsNumber: 207,
            lastUpdateType: .asked(Date(timeInterval: -90000, since: Date())),
            backgroundColors: $0,
            tags: ["123", "perfomance", "microsoft-ui-automation", "css", "c++",
                   "123", "perfomance", "microsoft-ui-automation", "css", "c++"]
        )
    }
    
    // MARK: - States
    
    @State private var selectedItem: UUID?
    
    // MARK: - Properties
    
    let columns = [
        GridItem(.adaptive(minimum: 267), spacing: 24)
    ]
    
    var defaultSpacing: CGFloat {
        UIDevice.current.userInterfaceIdiom.isPad ? 24 : 12
    }
    
    // MARK: - Views
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: defaultSpacing) {
                ForEach(data) { item in
                    itemView(item)
                }
            }
            .padding(EdgeInsets.horizontal(defaultSpacing))
            .padding(.bottom, defaultSpacing)
        }
        .background(Color.background)
    }

    func itemView(_ item: QuestionItemView.Model) -> some View {
        ZStack {
            NavigationLink(destination: EmptyView(), tag: item.id, selection: $selectedItem) {
                EmptyView()
            }
            .buttonStyle(PlainButtonStyle())
            
            Button(action: { selectedItem = item.id }) {
                QuestionItemView(model: item)
            }
            .buttonStyle(PlainButtonStyle())
        }
    }
}

// MARK: - Previews

struct PageView_Previews: PreviewProvider {
    
    static var previews: some View {
        PageView()
    }
}

// MARK: - Colors

fileprivate extension UIColor {
    
    static let foreground = PaletteCore.dullGray
    static let background = PaletteCore.bluishblack
    static let navigationBackground = PaletteCore.grayblue.withAlphaComponent(0.5).rgbaToRgb(by: .background)
}

fileprivate extension Color {
    
    static let background = Palette.bluishblack
    static let navigation = Color(.navigationBackground)
}
