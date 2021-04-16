//
//  String+Extensions.swift
//  StackOv (Common module)
//
//  Created by Erik Basargin
//  Copyright © 2021 Erik Basargin. All rights reserved.
//

import Foundation

public extension String {
    
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
    
    static func roundNumberWithAbbreviations(number: Int?) -> String {
        guard let number = number else {
            return ""
        }

        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.groupingSeparator = ","
        
        if number < 1000 {
            return formatter.string(from: NSNumber(value: number)) ?? ""
        } else {
            let numberWithAbbreviation = number / 1000
            return (formatter.string(from: NSNumber(value: numberWithAbbreviation)) ?? "") + "K"
        }
    }
    
}
