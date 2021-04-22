//
//  ServiceError.swift
//  StackOv (Errors module)
//
//  Created by Erik Basargin
//  Copyright © 2021 Erik Basargin. All rights reserved.
//

import Foundation

public enum ServiceError: DisplaybleError {

    case url(code: URLError.Code, urlString: String)
    case urlComponents(URLComponents)
}

// MARK: - Extensions

public extension ServiceError {
    
    var title: String {
        switch self {
        case let .url(code, urlString):
            #if DEBUG
            return "Client error \(code), url: \(urlString)"
            #else
            return "Client error \(code)"
            #endif
        case .urlComponents:
            return "Client error"
        }
    }
    
    var errorDescription: String? {
        switch self {
        case .url:
            return nil
        case let .urlComponents(components):
            #if DEBUG
            return "Url components: \(components)"
            #else
            return nil
            #endif
        }
    }
}

