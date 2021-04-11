//
//  PageView.swift
//  StackOv (FavoriteFlow module)
//
//  Created by Evgeny Novgorodov
//  Copyright © 2021 Erik Basargin. All rights reserved.
//

import SwiftUI
import Palette
import Common
import Introspect
import Components
import AppScript

struct PageView: View {
    
    // MARK: - States
    
    @Store private var store: FavoriteStore
    
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
                        store.reloadQuestions()
                    }
            case .emptyContent:
                Text("empty")
            case let .content(model):
                content(model)
            case .loading:
                Text("Loading")
            case .error:
                Text("error")
            }
        }.phoneToolbar {
            ToolbarItemGroup(placement: ToolbarItemPlacement.navigationBarTrailing) {
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
            Text("Favorite Questions")
                .textCase(.none)
                .font(.system(size: 22, weight: .bold))
            
            Spacer()
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
            ThreadItemView(model: item)
        }.buttonStyle(PlainButtonStyle())
    }
    
    func destinationView(_ item: QuestionModel) -> some View {
        EmptyView() // TODO: - Need to implement
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
