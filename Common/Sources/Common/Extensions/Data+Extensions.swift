//
//  Data+Extensions.swift
//  StackOv (Common module)
//
//  Created by  Erik Basargin
//  Copyright © 2021 Erik Basargin. All rights reserved.
//

import Foundation
import Errors

public extension Data {
    
    func toJsonString(options: JSONSerialization.WritingOptions = []) throws -> String {
        let json = try JSONSerialization.jsonObject(with: self, options: .mutableContainers)
        let data = try JSONSerialization.data(withJSONObject: json, options: options)
        if let jsonString = String(data: data, encoding: .utf8) {
            return jsonString
        } else {
            throw DataError.wrongEncoding(data: data, encoding: .utf8)
        }
    }
}
