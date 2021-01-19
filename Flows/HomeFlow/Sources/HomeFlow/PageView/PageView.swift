//
//  PageView.swift
//  This source file is part of the StackOv open source project
//

import SwiftUI
import Palette
import Common
import Introspect
import Components
import AppScript
import struct PageStore.QuestionItemModel

struct PageView: View {

    // MARK: - States

    @Store var store: PageStore
    @State private var selectedItem: Int?
    
    // MARK: - Properties
    
    var columns: [GridItem] {
        [GridItem(.adaptive(minimum: 267), spacing: defaultSpacing)]
    }
    
    var defaultSpacing: CGFloat {
        UIDevice.current.userInterfaceIdiom.isPad ? 18 : 12
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
    
    func content(_ models: [PostItemViewModel] = []) -> some View {
        LazyVGrid(columns: columns, spacing: defaultSpacing) {
            ForEach(models) { item in
                itemView(item)
            }
        }
        .padding(.all, defaultSpacing)
    }

    func itemView(_ item: PostItemView.Model) -> some View {
        ZStack {
            NavigationLink(destination: EmptyView(), tag: item.id, selection: $selectedItem) {
                EmptyView()
            }
            .buttonStyle(PlainButtonStyle())
            
            Button(action: { selectedItem = item.id }) {
                PostItemView(model: item)
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
    
    func toViewModel() -> [PostItemViewModel] {
        let colors = Palette.linearGradientPalette
        var colorIndex: Int = (0..<colors.count).randomElement() ?? 0
        
        var result: [PostItemViewModel] = []
        for item in self {
            if colorIndex > colors.count - 1 { colorIndex = 0 }
            result.append(PostItemViewModel.from(model: item, backgroundColors: colors[colorIndex]))
            colorIndex += 1
        }
        
        return result
    }
}
