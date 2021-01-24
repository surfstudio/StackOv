//
//  SafariView.swift
//  StackOv (Components module)
//
//  Created by Erik Basargin
//  Copyright © 2021 Erik Basargin. All rights reserved.
//

import SwiftUI
import Palette
import SafariServices

struct SafariView: UIViewControllerRepresentable {
    
    let url: URL

    func makeUIViewController(context: UIViewControllerRepresentableContext<SafariView>) -> SFSafariViewController {
        let controller = SFSafariViewController(url: url)
        controller.preferredBarTintColor = UIColor.background
        controller.preferredControlTintColor = UIColor.title
        return controller
    }

    func updateUIViewController(_ uiViewController: SFSafariViewController, context: UIViewControllerRepresentableContext<SafariView>) {}
}

// MARK: - Colors

fileprivate extension UIColor {
    
    static let title = PaletteCore.main
    static let background = PaletteCore.bluishblack
}

