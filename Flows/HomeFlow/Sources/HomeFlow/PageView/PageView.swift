//
//  PageView.swift
//  StackOv (HomeFlow module)
//
//  Created by Erik Basargin
//  Copyright © 2021 Erik Basargin. All rights reserved.
//

import SwiftUI
import Palette
import Common
import Introspect
import Components
import AppScript
import struct PageStore.QuestionItemModel

struct PageView: View {
    
    // FIXIT: - Need to replace this to mock service
    let data = Palette.linearGradientPalette.enumerated().map {
        QuestionItemViewModel(
            id: $0,
            title: "How to make TouchableOpacity wrap its content when nested inside parent that has flex = 1",
            hasAcceptedAnswer: false,
            answersNumber: 3,
            votesNumber: 15,
            viewsNumber: 207,
            lastUpdateType: .asked(Date(timeInterval: -90000, since: Date())),
            backgroundColors: $1,
            tags: ["123", "perfomance", "microsoft-ui-automation", "css", "c++",
                   "123", "perfomance", "microsoft-ui-automation", "css", "c++"]
        )
    }
    
    // MARK: - States

    @Store var store: PageStore
    @State private var selectedItem: Int?
    
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
            switch store.state {
            case .unknown:
                Text("")
                    .onAppear {
                        store.loadQuestions()
                    }
            case .emptyContent:
                Text("empty")
            case let .content(model):
                content(model.toViewModel())
            case .loading:
                Text("Loading")
            case .error:
                Text("error")
            }
        }
    }
    
    func content(_ models: [QuestionItemViewModel] = []) -> some View {
        LazyVGrid(columns: columns, spacing: defaultSpacing) {
            ForEach(models) { item in
                itemView(item)
            }
        }
        .padding(EdgeInsets.horizontal(defaultSpacing))
        .padding(.bottom, defaultSpacing)
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

// MARK: - Extensions

fileprivate extension Array where Element == QuestionItemModel {
    
    func toViewModel() -> [QuestionItemViewModel] {
        let colors = Palette.linearGradientPalette
        var colorIndex: Int = (0..<colors.count).randomElement() ?? 0
        
        var result: [QuestionItemViewModel] = []
        for item in self {
            if colorIndex > colors.count - 1 { colorIndex = 0 }
            result.append(QuestionItemViewModel.from(model: item, backgroundColors: colors[colorIndex]))
            colorIndex += 1
        }
        
        return result
    }
}
