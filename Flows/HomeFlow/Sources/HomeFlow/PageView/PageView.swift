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
import ThreadFlow

struct PageView: View {
    
    // MARK: - States
    
    @Environment(\.sizeCategory) var sizeCategory: ContentSizeCategory
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    @Environment(\.mainContentSize) var mainContentSize
    
    @Store var sidebarStore: SidebarStore
    @Store var store: PageStore
    @State var isFilterViewPresented = false
    
    // MARK: - Properties
    
    var columns: [GridItem] {
        sizeCategory.isAccessibilityCategory
            ? [GridItem(.flexible(minimum: 267), spacing: defaultSpacing)]
            : [GridItem(.adaptive(minimum: 267), spacing: defaultSpacing)]
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
                        store.prepareCollectionItemWidthFor(mainContentWidth: mainContentSize.width)
                        store.firstReloadQuestions()
                    }
            case .emptyContent:
                Text("empty")
            case let .content(model):
                content(model)
                    .onChange(of: mainContentSize) { value in
                        store.prepareCollectionItemWidthFor(mainContentWidth: value.width)
                    }
            case .loading:
                loadingView(shimmerIsActive: true)
            case .error:
                loadingView(shimmerIsActive: false)
            }
        }
        .padToolbar {
            ToolbarItemGroup(placement: .navigationBarLeading) {
                SidebarLeftButton()
            }
        }
        .phoneToolbar {
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
            
            if case .content = store.state {
                filterButton(style: .default)
            }
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
            ThreadItemView(model: item, preferredCollectionWidth: store.itemCollectionWidth)
        }.buttonStyle(ThreadItemNavigationLinkStyle())
    }
    
    func destinationView(_ item: QuestionModel) -> some View {
        ThreadFlow()
            .environmentObject(StoresAssembler.shared.resolve(ThreadStore.self, argument: item)!)
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
        let shimmerConfig = getShimmerConfig(animation: shimmerIsActive)
        return VStack(spacing: .zero) {
            if UIDevice.current.userInterfaceIdiom.isPad {
                sectionHeader
            }
            
            LazyVGrid(columns: columns, spacing: defaultSpacing) {
                ForEach(0..<getNumberOfLoadingItems(), id: \.self) { item in
                    PostItemLoadingView(shimmerIsActive: shimmerIsActive)
                        .environmentObject(shimmerConfig)
                }
            }.padding(.all, defaultSpacing)
        }
    }
    
    // MARK: - Methods
    
    func getShimmerConfig(animation: Bool) -> ShimmerConfig {
        let config = ShimmerConfig(bgColor: Color.clear, fgColor: Color.clear)
        if animation { config.startAnimation() }
        return config
    }
    
    func getNumberOfLoadingItems() -> Int {
        let sideBarWidth: CGFloat
        
        if UIDevice.current.userInterfaceIdiom.isPhone  {
            sideBarWidth = 0
        } else {
            sideBarWidth = SidebarConstants.sidebarWidth(style: sidebarStore.sidebarStyle,
                                                         isAccessibility: sizeCategory.isAccessibilityCategory)
        }
        
        let contentWidht = UIScreen.main.bounds.width - sideBarWidth
        let contentHeight =  UIScreen.main.bounds.height
        return Int((((contentWidht - defaultSpacing) / (267 + defaultSpacing)).rounded(.down)))
            * Int((((contentHeight - defaultSpacing) / (223 + defaultSpacing)).rounded(.down)))
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
