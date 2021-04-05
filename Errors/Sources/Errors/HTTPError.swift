//
//  HTTPError.swift
//  StackOv (Errors module)
//
//  Created by Влад Климов
//  Copyright © 2021 Erik Basargin. All rights reserved.
//

import Foundation

public struct HTTPError: DisplaybleError {
    
    // MARK: - Properties
    
    public let statusCode: HTTPStatusCode
    
    // MARK: - Initialization
    
    public init?(_ error: Error) {
        guard let statusCode = error as? HTTPStatusCode else {
            return nil
        }
        
        switch statusCode.responseType {
        case .success, .informational, .redirection:
            return nil
        case .clientError, .serverError, .undefined:
            self.statusCode = statusCode
        }
    }
}

// MARK: - Extensions

public extension HTTPError {
    
    var title: String {
        switch statusCode.responseType {
        case .clientError:
            return "Client error \(statusCode.rawValue)"
        case .serverError:
            return "Server error \(statusCode.rawValue)"
        case .success, .informational, .redirection, .undefined:
            return "Unknown error"
        }
    }
    
    var errorDescription: String? {
        #if DEBUG
        return localizedDescription
        #else
        switch statusCode {
        case .badRequest, .unauthorized, .forbidden,
             .notFound, .teapot, .tooManyRequests, .noResponse:
            return localizedDescription
        case .serviceUnavailable:
            return "The server is currently unavailable"
        default:
            return nil
        }
        #endif
    }
}

