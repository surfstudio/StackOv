//
//  File.swift
//  
//
//  Created by Erik Basargin on 11/10/2020.
//

import Foundation

public extension String {
    
    var urlQueryAllowed: String? {
        addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
    }
}
