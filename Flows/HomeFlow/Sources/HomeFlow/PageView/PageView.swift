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

    @Store private var store: PageStore
    @State private var selectedItem: Int?
    @State private var isFilterViewPresented = false
    
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
                content(model)
            case .loading:
                Text("Loading")
            case .error:
                Text("error")
            }
        }
    }
    
    var sectionHeader: some View {
        HStack {
            Text("All Questions")
                .textCase(.none)
                .font(.system(size: 22, weight: .bold))
            
            Spacer()
            
            FilterButton(activeFilters: .constant(3)) {
                isFilterViewPresented = true
            }.sheet(isPresented: $isFilterViewPresented) {
                FilterView(isOpened: $isFilterViewPresented)
                    .environmentObject(store.filterStore)
            }
        }
        .padding(.all, defaultSpacing)
        .frame(height: 30)
        .listRowInsets(EdgeInsets.zero)
        .padding(EdgeInsets.all(24))
        .background(Color.background)
    }
    
    // MARK: - View methods
    
    func content(_ models: [QuestionModel] = []) -> some View {
        VStack(spacing: .zero) {
            sectionHeader
            
            LazyVGrid(columns: columns, spacing: defaultSpacing) {
                ForEach(models) { item in
                    itemView(item)
                }
            }
            .padding(.all, defaultSpacing)
        }
    }

    func itemView(_ item: QuestionModel) -> some View {
        ZStack {
            NavigationLink(destination: destinationView(item), tag: item.id, selection: $selectedItem) {
                EmptyView()
            }
            .buttonStyle(PlainButtonStyle())
            
            Button(action: { selectedItem = item.id }) {
                PostItemView(model: item)
            }
            .buttonStyle(PlainButtonStyle())
        }
    }
    
    func destinationView(_ item: QuestionModel) -> some View {
        PostView()
            .environmentObject(StoresAssembler.shared.resolve(PostStore.self, argument: item)!)
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
    
    static let background = Palette.bluishblack
}
