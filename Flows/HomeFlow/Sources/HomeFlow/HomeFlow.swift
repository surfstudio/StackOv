//
//  HomeFlow.swift
//  This source file is part of the StackOv open source project
//

import SwiftUI
import Palette
import Common
import Introspect
import Components

public struct HomeFlow: View {
    
    static private let firstId = UUID()
    let pages: [PageModel] = [
        .init(id: firstId, title: "Page 1ashfksajdfhkjasdfhkjashfjklasdf"),
        .init(title: "Page 2"),
        .init(title: "Page 3"),
        .init(title: "Page 4ashfksajdfhkjasdfhkjashfjklasdf"),
        .init(title: "Page 5ashfksajdfhkjasdfhkjashfjklasdf"),
        .init(title: "Page 6ashfksajdfhkjasdfhkjashfjklasdf"),
        .init(title: "Page 7ashfksajdfhkjasdfhkjashfjklasdf"),
        .init(title: "Page 8ashfksajdfhkjasdfhkjashfjklasdf"),
        .init(title: "Page 9ashfksajdfhkjasdfhkjashfjklasdf"),
        .init(title: "Page 10ashfksajdfhkjasdfhkjashfjklasdf"),
        .init(title: "Page 11ashfksajdfhkjasdfhkjashfjklasdf"),
        .init(title: "Page 12ashfksajdfhkjasdfhkjashfjklasdf"),
        .init(title: "Page 13ashfksajdfhkjasdfhkjashfjklasdf"),
        .init(title: "Page 14ashfksajdfhkjasdfhkjashfjklasdf"),
        .init(title: "Page 15ashfksajdfhkjasdfhkjashfjklasdf"),
        .init(title: "Page 16ashfksajdfhkjasdfhkjashfjklasdf"),
        .init(title: "Page 17ashfksajdfhkjasdfhkjashfjklasdf"),
        .init(title: "Page 18ashfksajdfhkjasdfhkjashfjklasdf"),
        .init(title: "Page 19ashfksajdfhkjasdfhkjashfjklasdf"),
        .init(title: "Page 20ashfksajdfhkjasdfhkjashfjklasdf"),
        .init(title: "Page 21ashfksajdfhkjasdfhkjashfjklasdf"),
        .init(title: "Page 22ashfksajdfhkjasdfhkjashfjklasdf")
    ]
    @State private var currentPage: UUID = firstId

    public init() {}
    
    public var body: some View {
//        NavigationView {
            content
//                .navigationBarTitle("", displayMode: .inline)
//                .modifier(NavigationViewIntrospectModifier())
//                .toolbar {
//                    ToolbarItem(placement: .principal) {
//                        TextField("Search", text: .constant(""))
//                            .padding(.horizontal)
//                            .padding(.vertical, 4)
//                            .frame(width: 413)
//                            .background(Palette.white.opacity(0.08))
//                            .cornerRadius(5.0)
//                    }
//                }
//        }
//        .navigationViewStyle(StackNavigationViewStyle())
    }
    
    var content: some View {
        VStack(spacing: .zero) {
            Divider()
                .background(Color.white.opacity(0.08))
            
            PagesView(pages: pages, currentPage: $currentPage)
            
            TabView(selection: $currentPage) {
                ForEach(pages) { page in
                    PageView(title: page.title).tabItem {
                        EmptyView()
                    }.tag(page.id)
                }
            }
        }
    }
}

// MARK: - Previews

struct HomeFlow_Previews: PreviewProvider {
    
    static var previews: some View {
        HomeFlow()
    }
}

// MARK: - View Modifiers

fileprivate struct NavigationViewIntrospectModifier: ViewModifier {
    func body(content: Content) -> some View {
        content.introspectNavigationController {
            $0.view.backgroundColor = UIColor.background
            $0.navigationBar.setBackgroundImage(UIColor.navigationBackground.image(), for: .default)
            
            $0.navigationBar.tintColor = UIColor.foreground
            
            // Hack for changing UIHostViewController with wight background
            $0.children.first?.view.backgroundColor = .clear
        }
    }
}

// MARK: - Colors

fileprivate extension UIColor {
    
    static let foreground = PaletteCore.dullGray
    static let background = PaletteCore.bluishblack
    static let navigationBackground = PaletteCore.grayblue.withAlphaComponent(0.5).rgbaToRgb(by: .background)
}
