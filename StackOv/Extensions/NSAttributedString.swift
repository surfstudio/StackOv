//
//  NSAttributedString.swift
//  StackOv
//
//  Created by Erik Basargin on 19/05/2020.
//  Copyright © 2020 Ephedra Software. All rights reserved.
//

import Foundation
import SwiftUI

extension NSAttributedString {
    typealias LazyString = (ColorScheme) throws -> NSAttributedString
    
    static func from(htmlString: String, stylesheet: String? = nil) -> LazyString {
        { colorScheme in
            let defaultStylesheet = """
            * { font-family: -apple-system; font-size: 15px; }
            code, pre { font-family: Menlo; font-weight: 400; background-color: \(colorScheme == .dark ? "#404345" : "#e4e6e8"); white-space: pre-wrap; }
            """
            let string = "<style>" + (stylesheet ?? defaultStylesheet) + "</style>" + htmlString
            return try NSAttributedString(
                data: Data(string.utf8),
                options: [.documentType: NSAttributedString.DocumentType.html],
                documentAttributes: nil
            )
        }
    }
}
