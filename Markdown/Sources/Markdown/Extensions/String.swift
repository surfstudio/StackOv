//
//  String.swift
//  StackOv (Markdown module)
//
//  Created by Erik Basargin
//  Copyright © 2021 Erik Basargin. All rights reserved.
//

import Foundation

extension String {
    
    init?(htmlString: String) {
        guard let data = htmlString.data(using: .utf8) else { return nil }
        
        let options: [NSAttributedString.DocumentReadingOptionKey: Any] = [
            .documentType: NSAttributedString.DocumentType.html,
            .characterEncoding: String.Encoding.utf8.rawValue
        ]
        guard let attributedString = try? NSAttributedString(data: data, options: options, documentAttributes: nil) else {
            return nil
        }
        self.init(attributedString.string)
    }
    
    func firstMatch(regex: String, group: Int) throws -> String? {
        let regex = try NSRegularExpression(pattern: regex)
        if let match = regex.firstMatch(in: self, options: [], range: NSRange(0..<self.count)),
            let range = Range(match.range(at: group), in: self) {
            return String(self[range])
        }
        return nil
    }
}
