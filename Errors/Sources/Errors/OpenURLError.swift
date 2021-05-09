//
//  OpenURLError.swift
//  StackOv (Errors module)
//
//  Created by  Erik Basargin
//  Copyright © 2021 Erik Basargin. All rights reserved.
//

import Foundation

public enum OpenURLError: DisplaybleError {
    case canNotBeOpened(URL)
}

// MARK: - Extensions

public extension OpenURLError {
    
    var title: String {
        "🤷‍♂️"
    }
    
    var errorDescription: String? {
        switch self {
        case let .canNotBeOpened(url):
            return """
                For some reason, the url \(url.absoluteString) cannot be oppened.
                This link is saved in the Clipboard.
            """
        }
    }
}

