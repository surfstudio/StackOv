//
//  DisplaybleError.swift
//  StackOv (Errors module)
//
//  Created by Erik Basargin
//  Copyright © 2021 Erik Basargin. All rights reserved.
//

import Foundation

public protocol DisplaybleError: LocalizedError {
    
    /// A short localized message describing what error occurred.
    var title: String { get }
    
    /// A localized message describing what error occurred.
    var description: String? { get }
}

public extension DisplaybleError {
    
    var description: String? { errorDescription }
}
