//
//  DoubleColumnView.swift
//  StackOv
//
//  Created by Erik Basargin on 31/05/2020.
//  Copyright © 2020 Ephedra Software. All rights reserved.
//

import SwiftUI

@available(iOS 13.0, OSX 10.15, tvOS 13.0, watchOS 6.0, *)
struct DoubleColumnView<FirstColumn: View, SecondColumn: View>: View {

    typealias Content = TupleView<(FirstColumn, SecondColumn)>
    
    private let content: () -> Content
    private let preferredDisplayMode: UISplitViewController.DisplayMode
    
    init(preferredDisplayMode: UISplitViewController.DisplayMode = .automatic, @ViewBuilder content: @escaping () -> Content) {
        self.content = content
        self.preferredDisplayMode = preferredDisplayMode
    }
    
    var body: some View {
        let (firstColumn, secondColumn) = content().value
        let controllers = [UIHostingController(rootView: firstColumn), UIHostingController(rootView: secondColumn)]
        return SplitViewController(controllers: controllers, preferredDisplayMode: preferredDisplayMode)
    }
    
    func preferredDisplayMode(_ preferredDisplayMode: UISplitViewController.DisplayMode) -> Self {
        DoubleColumnView(preferredDisplayMode: preferredDisplayMode, content: content)
    }
    
}

fileprivate struct SplitViewController: UIViewControllerRepresentable {
    public var controllers: [UIViewController]
    public var preferredDisplayMode: UISplitViewController.DisplayMode

    public func makeUIViewController(context: UIViewControllerRepresentableContext<SplitViewController>) -> UISplitViewController {
        let splitViewController = UISplitViewController()
        splitViewController.preferredDisplayMode = preferredDisplayMode
        splitViewController.viewControllers = controllers
        return splitViewController
    }

    public func updateUIViewController(_ uiViewController: UISplitViewController, context: UIViewControllerRepresentableContext<SplitViewController>) {
        uiViewController.preferredDisplayMode = preferredDisplayMode
        uiViewController.viewControllers = controllers
    }
}
