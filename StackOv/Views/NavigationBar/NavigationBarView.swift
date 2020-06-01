//
//  NavigationBarView.swift
//  StackOv
//
//  Created by Erik Basargin on 10/05/2020.
//  Copyright © 2020 Ephedra Software. All rights reserved.
//

import SwiftUI

struct NavigationBarView: View {
    @EnvironmentObject var stackoverflowStore: StackoverflowStore
    @EnvironmentObject var transitionStore: TransitionStore
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    enum Constants {
        static var height: CGFloat {
            if UIDevice.current.userInterfaceIdiom.isPhone {
                return 44
            }
            return 50
        }
    }
    
    enum Style {
        case searchBar
        case simpleBar
    }
    
    let style: Style
    
    init(_ style: Style = .simpleBar) {
        self.style = style
    }
    
    var body: some View {
        Group {
            subBody
                .frame(height: Constants.height)
                .background(Color.background)
                .clipped()
                .shadow(color: .shadow, radius: 10, x: 0, y: 2)
                .padding(.bottom, 20)
        }
        .clipped()
    }
    
    var subBody: some View {
        Group {
            if UIDevice.current.userInterfaceIdiom.isMac {
                HStack { content.padding(.horizontal, 16) }
            } else {
                HStack {
                    GeometryReader { geometry in
                        self.content.modifier(PaddingsModifier(
                            orientation: self.transitionStore.deviceOrientation,
                            safeAreaInsets: geometry.safeAreaInsets
                        ))
                    }
                }
            }
        }
    }
    
    var content: some View {
        switch style {
        case .searchBar:
            return AnyView(searchBar)
        case .simpleBar:
            return AnyView(simpleBar)
        }
    }
    
    var searchBar: some View {
        SearchBarView()
            .environmentObject(self.stackoverflowStore.searchStore)
    }
    
    var simpleBar: some View {
        HStack(spacing: .zero) {
            Spacer()
        }
        .frame(height: 33)
        .padding(.horizontal, 6)
    }
}

// MARK: - Previews

#if DEBUG
struct NavigationBarView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            NavigationBarView(.searchBar)
                .padding()
                .previewLayout(.sizeThatFits)
                .background(Color.background)
                .environment(\.colorScheme, .light)
                .environmentObject(StackoverflowStore())
            
            NavigationBarView(.searchBar)
                .padding()
                .previewLayout(.sizeThatFits)
                .background(Color.background)
                .environment(\.colorScheme, .dark)
                .environmentObject(StackoverflowStore())
        }
    }
}
#endif

// MARK: - Extensions

fileprivate extension Image {
    static let back = Image(systemName: "chevron.left")
}

fileprivate extension Color {
    static let foreground = Color("searchBarForeground")
    static let background = Color("mainBackground")
    static let shadow = Color("navigationBarShadow")
}

// MARK: - View Modifiers

fileprivate struct PaddingsModifier: ViewModifier {
    var orientation: UIDeviceOrientation
    var safeAreaInsets: EdgeInsets
    
    func body(content: Content) -> some View {
        return content
            .padding(.top, 8)
            .padding(
                .leading,
                orientation == .landscapeLeft || orientation == .landscapeRight ? safeAreaInsets.leading + 16 : 16
            )
            .padding(
                .trailing,
                orientation == .landscapeLeft || orientation == .landscapeRight ? safeAreaInsets.trailing + 16 : 16
            )
            .background(Color.background)
    }
}
