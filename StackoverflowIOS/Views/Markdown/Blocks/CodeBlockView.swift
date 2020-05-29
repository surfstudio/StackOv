//
//  CodeBlockView.swift
//  StackoverflowIOS
//
//  Created by Erik Basargin on 17/05/2020.
//  Copyright © 2020 Ephedra Software. All rights reserved.
//

import SwiftUI
import Highlightr

extension Markdown {
    
    struct CodeBlockView: MarkdownUnitView {
        let unit: Unit
        
        var body: some View {
            guard case let .codeBlock(_, code) = unit.type else {
                return AnyView(EmptyView())
            }
//            if let lang = codeType {
//                return AnyView(content(codeType: codeType, code: code))
//            } else {
                return AnyView(content(code: code))
//            }
        }
        
//        private func content(codeType: String?, code: String) -> some View {
//            ScrollView(.horizontal, showsIndicators: true) {
//                CodeView(codeType: codeType, code: code)
//                    .scaledToFit()
//            }
//            .padding([.leading, .top, .trailing], 12)
//            .background(Color.background)
//            .cornerRadius(6)
//            .padding(.bottom, 3)
//        }
        
        private func content(code: String) -> some View {
            ScrollView(.horizontal, showsIndicators: true) {
                VStack(alignment: .center, spacing: .zero) {
                    Text(code)
                        .font(.custom("Menlo-Regular", size: 13))
                        .foregroundColor(.foreground)
                        .fixedSize(horizontal: false, vertical: true)
                }
            }
            .padding([.leading, .top, .trailing], 12)
            .background(Color.background)
            .cornerRadius(6)
            .padding(.bottom, 3)
        }
    }
    
}

//fileprivate struct CodeView: UIViewRepresentable {
//    let codeType: String?
//    let code: String
//
//    init(codeType: String?, code: String) {
//        self.codeType = codeType
//        self.code = code
//    }
//
//    private var textStorage = CodeAttributedString()
//
//    func makeUIView(context: Context) -> UITextView {
//        textStorage.language = codeType?.lowercased()
//        let layoutManager = NSLayoutManager()
//        textStorage.addLayoutManager(layoutManager)
//
//        let textContainer = NSTextContainer(size: .zero)
//        layoutManager.addTextContainer(textContainer)
//
//        let textView = UITextView(frame: .zero, textContainer: textContainer)
//        textView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
//        textView.autocorrectionType = UITextAutocorrectionType.no
//        textView.autocapitalizationType = UITextAutocapitalizationType.none
//        textView.font = UIFont(name: "Menlo-Regular", size: 13)
//        textView.textColor = UIColor(named: "codeBlockForeground")
//        textView.isSelectable = true
//        textView.isUserInteractionEnabled = true
//        textView.isEditable = false
//        textView.isScrollEnabled = false
//        textView.dataDetectorTypes = .all
//        textView.backgroundColor = .clear
//        textView.textContainer.lineFragmentPadding = .zero
//        textView.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
//        textView.text = code
//
//        return textView
//    }
//
//    func updateUIView(_ uiView: UITextView, context: Context) {}
//}

// MARK: - Previews

#if DEBUG
struct CodeBlockView_Previews: PreviewProvider {
    static let unit = Markdown.Unit("""
    ```
    func convertHtml() -> NSAttributedString {
        guard let data = data(using: .utf8) else { return NSAttributedString() }
        if let attributedString = try? NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html], documentAttributes: nil) {
            return attributedString
        } else {
            return NSAttributedString()
        }
    }
    ```
    """)!.children.first!
    static var previews: some View {
        Group {
            Markdown.CodeBlockView(unit: unit)
                .padding()
                .previewLayout(.sizeThatFits)
                .background(Color.mainBackground)
                .environment(\.colorScheme, .light)
            
            Markdown.CodeBlockView(unit: unit)
                .padding()
                .previewLayout(.sizeThatFits)
                .background(Color.mainBackground)
                .environment(\.colorScheme, .dark)
        }
    }
}
#endif

// MARK: - Extensions

fileprivate extension Color {
    static let background = Color("codeBlockBackground")
    static let foreground = Color("codeBlockForeground")
    #if DEBUG
    static let mainBackground = Color("mainBackground")
    #endif
}
