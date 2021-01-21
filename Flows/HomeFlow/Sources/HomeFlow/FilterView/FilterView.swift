//
//  FilterView.swift
//  This source file is part of the StackOv open source project
//

import SwiftUI
import Palette

struct FilterView: View {
    
    // MARK: - States
    
    // TODO: Issue #28; This is mock logic
    @State var statesOfFilters: [FilterOption: Bool] = {
        var states = [FilterOption: Bool]()
        FilterOption.allCases.forEach { states[$0] = Bool.random() }
        return states
    }()
    
    @State var statesOfSorts: [SortOption: Bool] = {
        var states = [SortOption: Bool]()
        SortOption.allCases.forEach { states[$0] = false }
        return states
    }()
    
    // MARK: - Properties
    
    let onCancel: () -> Void
    let onDone: () -> Void
    
    // MARK: - Initialization
    
    init(onCancel: @escaping () -> Void, onDone: @escaping () -> Void) {
        self.onCancel = onCancel
        self.onDone = onDone
    }
    
    // MARK: - View
    
    var body: some View {
        NavigationView {
            content
                .navigationBarTitle("Filter", displayMode: .inline)
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button(action: onCancel) {
                            Text("Cancel")
                        }
                    }
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button(action: onDone) {
                            Text("Done")
                        }
                    }
                }
        }.accentColor(Color.main)
    }
    
    var content: some View {
        List {
            CustomSection(header: sectionHeader(title: "Filter by")) {
                ForEach(FilterOption.allCases) {
                    FilterOptionRow(statesOfFilters: $statesOfFilters, filterOption: $0)
                }
            }
            
            CustomSection(header: sectionHeader(title: "Sorted by")) {
                ForEach(SortOption.allCases) {
                    SortOptionRow(statesOfSorts: $statesOfSorts, sortOption: $0)
                }
            }
        }
    }
    
    // MARK: - View methods
    
    func sectionHeader(title: String) -> some View {
        Text(title)
            .foregroundColor(Color.sectionForeground)
            .padding(.top, 24)
            .padding(.bottom, 10)
    }
}

// MARK: - Previews

struct FilterView_Previews: PreviewProvider {
    
    static var previews: some View {
        FilterView(onCancel: {}, onDone: {})
    }
}

// MARK: - Colors

fileprivate extension Color {
    
    static let sectionForeground = Palette.dullGray
}

// MARK: - Custom section

fileprivate struct CustomSection<Parent: View, Content: View>: View {
    
    // MARK: - Properties
    
    let header: Parent
    let content: () -> Content
    
    // MARK: - Initialization
    
    init(header: Parent, @ViewBuilder content: @escaping () -> Content) {
        self.header = header
        self.content = content
    }
    
    // MARK: - View
    
    var body: some View {
        Section(header: header, content: content)
            .listRowInsets(EdgeInsets.leading(20))
            .frame(height: 50)
    }
}
