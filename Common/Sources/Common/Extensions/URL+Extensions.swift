//
//  URL+Extensions.swift
//  StackOv (Common module)
//
//  Created by  Erik Basargin
//  Copyright © 2021 Erik Basargin. All rights reserved.
//

import Foundation

extension URL: Identifiable {
    
    public var id: Int { hashValue }
}
