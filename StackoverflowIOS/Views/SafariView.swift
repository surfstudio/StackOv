//
//  SafariView.swift
//  StackoverflowIOS
//
//  Created by Erik Basargin on 30/05/2020.
//  Copyright © 2020 Ephedra Software. All rights reserved.
//

import SwiftUI
import SafariServices

struct SafariView: UIViewControllerRepresentable {
    let url: URL?

    func makeUIViewController(context: UIViewControllerRepresentableContext<SafariView>) -> SFSafariViewController {
        guard let url = url else { fatalError() }
        let controller = SFSafariViewController(url: url)
        controller.preferredBarTintColor = UIColor.background
        controller.preferredControlTintColor = UIColor.title
        return controller
    }

    func updateUIViewController(_ uiViewController: SFSafariViewController, context: UIViewControllerRepresentableContext<SafariView>) {}
}

fileprivate extension UIColor {
    static let title = UIColor(named: "questionTitle")
    static let background = UIColor(named: "mainBackground")
}
