//
//  URLSessionError.swift
//  StackOv (Errors module)
//
//  Created by  Erik Basargin
//  Copyright © 2021 Erik Basargin. All rights reserved.
//

import Foundation

public enum URLSessionError: DisplaybleError {
    case invalidResponse(URLResponse)
    case unknownHTTPCode(response: HTTPURLResponse)
}

// MARK: - Extensions

public extension URLSessionError {
    
    var title: String {
        #if DEBUG
        switch self {
        case .invalidResponse:
            return "Invalid response"
        case .unknownHTTPCode:
            return "Unknown HTTP code"
        }
        #else
        return "☕️"
        #endif
    }
    
    var errorDescription: String? {
        #if DEBUG
        switch self {
        case let .invalidResponse(response):
            return "\(response)"
        case let .unknownHTTPCode(response):
            return "\(response)"
        }
        #else
        return nil
        #endif
    }
}
