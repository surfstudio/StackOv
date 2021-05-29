//
//  PasteboardError.swift
//  StackOv (Errors module)
//
//  Created by  Erik Basargin
//  Copyright © 2021 Erik Basargin. All rights reserved.
//

import Foundation

public enum PasteboardError: DisplaybleError {
    case unknown
}

// MARK: - Extensions

public extension PasteboardError {
    
    var title: String {
        "🌚"
    }
    
    var errorDescription: String? {
        "Something went wrong..."
    }
}


