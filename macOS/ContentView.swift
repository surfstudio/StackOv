//
//  ContentView.swift
//  StackOv (macOS)
//
//  Created by Erik Basargin on 02/10/2020.
//

import SwiftUI
import CoreData
import Palette
import Introspect

struct Sidebar: View {
    var body: some View {
        List {
            Button("Item 1") {
                print("Item 1")
            }
            Button("Item 2") {
                print("Item 2")
            }
        }
        .listStyle(SidebarListStyle())
        .background(Palette.grayblue)
    }
}

func toggleSidebar() {
    NSApp.keyWindow?.firstResponder?.tryToPerform(#selector(NSSplitViewController.toggleSidebar(_:)), with: nil)
}

struct MainView: View {
    var body: some View {
        Text("Main View")
//        Palette.bluishblack
    }
}

//struct Toolbar: View {
//    var body: some View {
//        ToolbarItem(placement: ToolbarItemPlacement.navigation) {
//            Button(action: {}) {
//                Label("Add Item", systemImage: "plus")
//            }
//        }
//    }
//}

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)],
        animation: .default)
    private var items: FetchedResults<Item>
    
    @State private var text = ""
    
    init() {
        
    }

    var body: some View {
        NavigationView {
            Sidebar()
                .introspectVisualEffectView {
                    print("SubEffectView", $0)
                    $0.wantsLayer = true
                    $0.layer?.backgroundColor = PaletteCore.grayblue.cgColor
                }
            MainView()
                .introspectViewController {
                    print("vs", $0)
                    $0.view.wantsLayer = true
                    $0.view.layer?.backgroundColor = PaletteCore.grayblue.cgColor
                }
                .navigationTitle("")
//                .background(Color.navigationBar)
                .toolbar {
                    #if os(macOS)
                    ToolbarItem(placement: .navigation) {
                        Button(action: toggleSidebar) {
                            Label("Left sidebar", systemImage: "sidebar.left")
                        }
                    }
                    #endif
                    
                    ToolbarItem(placement: .principal) {
                        TextField("Search", text: $text)
                            .padding(.horizontal)
                            .padding(.vertical, 4)
                            .frame(width: 413)
        //                    .background(Palette.main)
        //                    .cornerRadius(5.0)
                    }
                }
        }
//        List {
//            ForEach(items) { item in
//                Text("Item at \(item.timestamp!, formatter: itemFormatter)")
//            }
//            .onDelete(perform: deleteItems)
//        }
//        .toolbar {
//            #if os(iOS)
//            EditButton()
//            #endif
//
//            Button(action: addItem) {
//                Label("Add Item", systemImage: "plus")
//            }
//        }
    }

    private func addItem() {
        withAnimation {
            let newItem = Item(context: viewContext)
            newItem.timestamp = Date()

            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { items[$0] }.forEach(viewContext.delete)

            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}

fileprivate extension Color {
    
    static let navigationBar = Palette.grayblue.opacity(0.5)
    
}

