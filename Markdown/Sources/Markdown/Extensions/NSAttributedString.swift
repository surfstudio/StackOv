//
//  NSAttributedString.swift
//  StackOv (Markdown module)
//
//  Created by Erik Basargin
//  Copyright © 2021 Erik Basargin. All rights reserved.
//

import Foundation
import enum SwiftUI.ColorScheme

public extension NSAttributedString {
    
    typealias HTMLResult = (_ colorScheme: ColorScheme, _ stylesheet: String?) throws -> NSAttributedString
    
    static func from(htmlString: String) -> HTMLResult {
        return { colorScheme, stylesheet in
            let defaultStylesheet = """
            * { font-family: -apple-system; font-size: 15px; }
            code, pre { font-family: Menlo; font-weight: 400; background-color: \(colorScheme == .dark ? "#404345" : "#e4e6e8"); white-space: pre-wrap; }
            """
            let string = "<style>" + (stylesheet ?? defaultStylesheet) + "</style>" + htmlString
            return try NSAttributedString(
                data: Data(string.utf8),
                options: [
                    .documentType: NSAttributedString.DocumentType.html,
                    .characterEncoding: String.Encoding.utf8.rawValue
                ],
                documentAttributes: nil
            )
        }
    }
}
