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
import struct PageStore.QuestionModel

struct PageView: View {

    // MARK: - States

    @Environment(\.sizeCategory) var sizeCategory: ContentSizeCategory
    @Store private var store: PageStore
    @State private var isFilterViewPresented = false
    
    // MARK: - Properties
    
    var columns: [GridItem] {
        sizeCategory.isAccessibilityCategory
            ? [GridItem(.flexible(minimum: 267), spacing: defaultSpacing)]
            : [GridItem(.adaptive(minimum: 267), spacing: defaultSpacing)]
    }
    
    var defaultSpacing: CGFloat {
        UIDevice.current.userInterfaceIdiom.isPad ? 18 : 12
    }
    
    let shimmerConfig: ShimmerConfig = ShimmerConfig(bgColor: Color.clear, fgColor: Color.clear)
    
    // MARK: - Views
    
    var body: some View {
        ScrollView {
            switch store.state {
            case .unknown:
                Text("")
                    .onAppear {
                        store.reloadQuestions()
                    }
            case .emptyContent:
                Text("empty")
            case let .content(model):
                content(model)
            case .loading:
                loadingView(shimmerIsActive: true)
            case .error:
                loadingView(shimmerIsActive: false)
            }
        }.phoneToolbar {
            ToolbarItemGroup(placement: ToolbarItemPlacement.navigationBarTrailing) {
                filterButton(style: .short)
                #if DEBUG
                Button(action: {}) {
                    Image(systemName: "person.crop.circle.fill")
                }
                #endif
            }
        }
    }
    
    var sectionHeader: some View {
        HStack {
            Text("All Questions")
                .font(.title2)
                .fontWeight(.bold)
                .textCase(.none)
            
            Spacer()
            
            filterButton(style: .default)
        }
        .padding(.all, defaultSpacing)
        .frame(height: 30)
        .listRowInsets(EdgeInsets.zero)
        .padding(.top, 24)
        .padding(.bottom, 6)
        .background(Color.background)
    }
    
    // MARK: - View methods
    
    func content(_ models: [QuestionModel]) -> some View {
        VStack(spacing: .zero) {
            if UIDevice.current.userInterfaceIdiom.isPad {
                sectionHeader
            }

            LazyVGrid(columns: columns, spacing: defaultSpacing) {
                ForEach(models) { item in
                    itemView(item)
                        .onAppear {
                            if models.last == item {
                                store.loadNextQuestions()
                            }
                        }
                }
            }
            .padding(.all, defaultSpacing)

            if store.loadMore {
                LoaderView()
                    .frame(width: 24, height: 24)
                    .padding(.vertical, 20)
            }
        }
    }

    func itemView(_ item: QuestionModel) -> some View {
        NavigationLink(destination: destinationView(item)) {
            PostItemView(model: item)
        }.buttonStyle(PlainButtonStyle())
    }
    
    func destinationView(_ item: QuestionModel) -> some View {
        PostView()
            .environmentObject(StoresAssembler.shared.resolve(PostStore.self, argument: item)!)
    }
    
    func filterButton(style: FilterButton.Style) -> some View {
        FilterButton(activeFilters: .constant(3), style: style) {
            isFilterViewPresented = true
        }
        .sheet(isPresented: $isFilterViewPresented) {
            FilterView(isOpened: $isFilterViewPresented)
                .environmentObject(store.filterStore)
        }
    }
    
    func loadingView(shimmerIsActive: Bool) -> some View {
        GeometryReader { geometry in
            VStack(spacing: .zero) {
                if UIDevice.current.userInterfaceIdiom.isPad {
                    sectionHeader
                }
                
                LazyVGrid(columns: columns, spacing: defaultSpacing) {
                    ForEach(0..<columnCount(geometry) * 2, id: \.self) { item in
                        PostItemLoadingView(shimmerIsActive: shimmerIsActive, shimmerConfig: shimmerConfig)
                    }
                }
                .padding(.all, defaultSpacing)
            }
        }
    }
    
    // MARK: - Methods
    
    func columnCount(_ geometry: GeometryProxy) -> Int {
        Int(((geometry.size.width - defaultSpacing) / (267 + defaultSpacing).rounded(.down)))
    }
    
}

// MARK: - Previews

struct PageView_Previews: PreviewProvider {
    
    static var previews: some View {
        PageView()
    }
}

// MARK: - Colors

fileprivate extension Color {
    
    static let background = Palette.bluishwhite | Palette.bluishblack
}
