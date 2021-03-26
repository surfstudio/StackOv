//
//  CodeView.swift
//  StackOv (Components module)
//
//  Created by Илья Князьков
//  Copyright © 2021 Erik Basargin. All rights reserved.
//

import SwiftUI
import Highlightr

struct CodeView: UIViewRepresentable {

    // MARK: - Nested types

    private enum Constants {
        static let codeFont = UIFont.init(name: "Menlo-Regular", size: 13)
    }

    typealias UIViewType = UITextView

    // MARK: - Private properties

    private let codeType: String?
    private let code: String
    private var textStorage = CodeAttributedString()

    // MARK: - Initialization

    init(codeType: String?, code: String) {
        self.codeType = codeType
        self.code = code
    }

    // MARK: - View

    func makeUIView(context: Context) -> UITextView {
        let (textContainer, layoutManager) = getTextContainerAndLayoutManager()

        textStorage.language = codeType?.lowercased()
        textStorage.addLayoutManager(layoutManager)
        layoutManager.addTextContainer(textContainer)

        return getTextView(with: code, container: textContainer)
    }

    func updateUIView(_ uiView: UITextView, context: Context) { }

    // MARK: - Private properties

    private func getTextView(with text: String, container: NSTextContainer) -> UITextView {
        let textView = UITextView(frame: .zero, textContainer: container)
        textView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        textView.autocorrectionType = .no
        textView.autocapitalizationType = .none
        textView.font = Constants.codeFont
        textView.isEditable = false
        textView.isScrollEnabled = false
        textView.dataDetectorTypes = .all
        textView.backgroundColor = .clear
        textView.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        textView.text = text
        return textView
    }

    private func getTextContainerAndLayoutManager() -> (container: NSTextContainer, manager: NSLayoutManager) {
        let textContainer = NSTextContainer(size: .zero)
        textContainer.lineFragmentPadding = .zero

        let layoutManager = NSLayoutManager()


        return (textContainer, layoutManager)
    }
}

// MARK: - Previews

struct CodeView_Previews: PreviewProvider {

    static let code = ("""
    func convertHtml() -> NSAttributedString {
        guard let data = data(using: .utf8) else { return NSAttributedString() }
        if let attributedString = try? NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html], documentAttributes: nil) {
            return attributedString
        } else {
            return NSAttributedString()
        }
    }
    """)
    static let codeType = "swift"

    static var previews: some View {
        CodeView(codeType: codeType, code: code)
    }
}

