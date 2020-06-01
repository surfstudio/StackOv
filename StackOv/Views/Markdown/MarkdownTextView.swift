//
//  MarkdownTextView.swift
//  StackOv
//
//  Created by Erik Basargin on 20/05/2020.
//  Copyright © 2020 Ephedra Software. All rights reserved.
//

import Foundation
import SwiftUI

struct MarkdownTextView: View {
    @State private var desiredHeight: CGFloat = .zero
    @State private var safariStatus: SafariStatus = .disable
    
    let attributedText: NSAttributedString.LazyString

    var body: some View {
        _MarkdownTextView(
            attributedText: self.attributedText,
            desiredHeight: self.$desiredHeight,
            safariStatus: self.$safariStatus
        )
        .frame(height: desiredHeight)
        .sheet(isPresented: Binding<Bool>(get: { self.safariStatus.isEnable }, set: { _ in }), onDismiss: {
            self.safariStatus = .disable
        }) {
            SafariView(url: self.safariStatus.url)
        }
    }
}

fileprivate enum SafariStatus {
    case enable(URL)
    case disable
    
    var isEnable: Bool {
        guard case .enable = self else {
            return false
        }
        return true
    }
    
    var url: URL? {
        guard case let .enable(url) = self else {
            return nil
        }
        return url
    }
}

fileprivate struct _MarkdownTextView: UIViewRepresentable {
    let attributedText: NSAttributedString.LazyString
    @Binding var desiredHeight: CGFloat
    @Binding var safariStatus: SafariStatus
    @Environment(\.colorScheme) var colorScheme: ColorScheme
    
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
        
        return textView
    }

    func updateUIView(_ uiView: UITextView, context: Context) {
        DispatchQueue.main.async {
            let attributedText = (try? self.attributedText(self.colorScheme)) ?? NSAttributedString()
            let mAttributedText = NSMutableAttributedString(attributedString: attributedText)
            mAttributedText.addAttribute(
                NSAttributedString.Key.foregroundColor,
                value: UIColor.foreground as Any,
                range: NSRange(location: 0, length: attributedText.string.count)
            )
            uiView.attributedText = mAttributedText
            
            let newSize = uiView.sizeThatFits(CGSize(width: uiView.frame.size.width, height: CGFloat.greatestFiniteMagnitude))
            self.desiredHeight = newSize.height
        }
    }
    
    final class Coordinator: NSObject, UITextViewDelegate {
        let view: _MarkdownTextView
        
        init(_ view: _MarkdownTextView) {
            self.view = view
        }
        
        func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {
            guard UIApplication.shared.canOpenURL(URL), ["http", "https"].contains(URL.scheme ?? "") else {
                return true
            }
            DispatchQueue.main.async {
                self.view.safariStatus = .enable(URL)
            }
            return false
        }
    }
}

fileprivate extension UIColor {
    static let foreground = UIColor(named: "questionTextForeground")
    static let title = UIColor(named: "questionTitle")
    static let background = UIColor(named: "mainBackground")
}
