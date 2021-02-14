//
//  MarkdownTextView.swift
//  StackOv (Components module)
//
//  Created by Erik Basargin
//  Copyright © 2021 Erik Basargin. All rights reserved.
//

import Foundation
import SwiftUI
import Markdown
import Common
import Palette

struct MarkdownTextView: View {
    
    // MARK: - States
    
    @State private var desiredHeight: CGFloat = .zero
    @State private var safariStatus: SafariStatus = .disable
    
    // MARK: - Properties
    
    let lazyHtmlText: NSAttributedString.HTMLResult

    // MARK: - View
    
    var body: some View {
        _MarkdownTextView(desiredHeight: $desiredHeight, safariStatus: $safariStatus, lazyHtmlText: lazyHtmlText)
            .frame(height: desiredHeight)
            .sheet(isPresented: .init(get: { self.safariStatus.isEnable }, set: { _ in }), onDismiss: { safariStatus = .disable }) {
                SafariView(url: safariStatus.url!)
            }
    }
}

// MARK: - SafariStatus

fileprivate enum SafariStatus {
    
    case enable(URL)
    case disable
}

fileprivate extension SafariStatus {
    
    var isEnable: Bool {
        guard case .enable = self else { return false }
        return true
    }
    
    var url: URL? {
        guard case let .enable(url) = self else { return nil }
        return url
    }
}

// MARK: - MarkdownTextView representation

fileprivate struct _MarkdownTextView: UIViewRepresentable {
    
    // MARK: - Nested types
    
    final class Coordinator: NSObject, UITextViewDelegate {
        let view: _MarkdownTextView
        
        init(_ view: _MarkdownTextView) {
            self.view = view
        }
        
        func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {
            guard UIApplication.shared.canOpenURL(URL), ["http", "https"].contains(URL.scheme ?? "") else {
                return true
            }
            if UIDevice.current.userInterfaceIdiom.isMacCatalyst {
                UIApplication.shared.open(URL, options: [:], completionHandler: nil)
            } else {
                DispatchQueue.main.async { [weak self] in
                    self?.view.safariStatus = .enable(URL)
                }
            }
            return false
        }
    }
    
    // MARK: - States
    
    @Environment(\.colorScheme) var colorScheme: ColorScheme
    @Binding var desiredHeight: CGFloat
    @Binding var safariStatus: SafariStatus
    
    // MARK: - Properties
    
    let lazyHtmlText: NSAttributedString.HTMLResult

    // MARK: - Methods
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    func makeUIView(context: Context) -> UITextView {
        let textView = UITextView()
        textView.delegate = context.coordinator
        textView.isSelectable = true
        textView.isUserInteractionEnabled = true
        textView.isEditable = false
        textView.isScrollEnabled = false
        textView.dataDetectorTypes = .all
        textView.backgroundColor = .clear
        textView.textContainer.lineFragmentPadding = .zero
        textView.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        textView.contentInset = .zero
        return textView
    }

    func updateUIView(_ uiView: UITextView, context: Context) {
        DispatchQueue.main.async {
            let attributedText = (try? lazyHtmlText(colorScheme, nil)) ?? NSAttributedString()
            let mAttributedText = NSMutableAttributedString(attributedString: attributedText)
            mAttributedText.addAttribute(
                NSAttributedString.Key.foregroundColor,
                value: UIColor.foreground as Any,
                range: NSRange(location: 0, length: attributedText.string.count)
            )
            uiView.attributedText = mAttributedText
            
            let newSize = uiView.sizeThatFits(CGSize(width: uiView.frame.size.width, height: CGFloat.greatestFiniteMagnitude))
            desiredHeight = newSize.height
        }
    }
}

// MARK: - Colors

fileprivate extension UIColor {
    
    static let foreground = PaletteCore.white
    static let background = PaletteCore.clear
}
