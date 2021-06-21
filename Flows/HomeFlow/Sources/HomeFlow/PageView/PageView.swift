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

    // MARK: - Constants

    private enum Constants {
        static let minItemWidth: CGFloat = 267
    }

    // MARK: - States
    
    @Environment(\.sizeCategory) var sizeCategory: ContentSizeCategory
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    
    @Store var store: PageStore
    @Store var sidebarStore: SidebarStore
    @State var isFilterViewPresented = false
    @State var itemWidth: CGFloat = 267
    
    // MARK: - Properties

    var contentWidth: CGFloat {
        let screenSize = UIApplication.shared.windows.first {$0.isKeyWindow}?.frame.size ?? UIScreen.main.bounds.size
        let width: CGFloat = UIDevice.current.orientation.isLandscape
            ? max(screenSize.width, screenSize.height)
            : min(screenSize.height, screenSize.width)
        let horisontalInset = horisontalInset(horizontalSizeClass: horizontalSizeClass)

        var sidebarWidth: CGFloat = 0
        if sidebarStore.isShown {
            sidebarWidth = SidebarConstants.sidebarWidth(style: sidebarStore.sidebarStyle,
                                                         isAccessibility: sizeCategory.isAccessibilityCategory)
        }
        
        return width - sidebarWidth - horisontalInset * 2
    }

    var columns: [GridItem] {
        sizeCategory.isAccessibilityCategory
            ? [GridItem(.flexible(minimum: Constants.minItemWidth), spacing: defaultSpacing)]
            : [GridItem(.adaptive(minimum: Constants.minItemWidth), spacing: defaultSpacing)]
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
                        store.firstReloadQuestions()
                    }
            case .emptyContent:
                Text("empty")
            case let .content(model):
                content(model)
                    .onAppear {
                        self.itemWidth = self.calculateItemWidth()
                    }
                    .onDidBecomeActive {
                        if itemWidth != self.calculateItemWidth() {
                            itemWidth = calculateItemWidth()
                        }
                    }
                    .onRotate { _ in
                        if UIDevice.current.orientation.isValidInterfaceOrientation {
                            itemWidth = calculateItemWidth()
                        }
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
            ThreadItemView(model: item, width: itemWidth)
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

    func horisontalInset(horizontalSizeClass: UserInterfaceSizeClass?) -> CGFloat {
        return UIDevice.current.userInterfaceIdiom.isPad ? 18 : 12
    }

    func calculateItemWidth() -> CGFloat {
        let numberInRow = floor((contentWidth + defaultSpacing) / (267 + defaultSpacing))
        return ((contentWidth + defaultSpacing) / numberInRow) - defaultSpacing
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
