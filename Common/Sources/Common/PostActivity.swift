//
//  PostActivity.swift
//  StackOv (Common module)
//
//  Created by Erik Basargin
//  Copyright © 2021 Erik Basargin. All rights reserved.
//

import Foundation

public enum PostActivity {
    
    case asked(Date)
    case modified(Date)
    case answered(Date)
    
}

// MARK: - Extensions

public extension PostActivity {
    
    var date: Date {
        switch self {
        case let .answered(date):
            return date
        case let .asked(date):
            return date
        case let .modified(date):
            return date
        }
    }
}
