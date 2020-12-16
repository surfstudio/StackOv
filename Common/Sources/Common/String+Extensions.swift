//
//  String+Extensions.swift
//  This source file is part of the StackOv open source project
//

import Foundation

public extension String {
    
    var urlQueryAllowed: String? {
        addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
    }
}
