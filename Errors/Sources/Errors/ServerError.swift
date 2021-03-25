//
//  ServerErrors.swift
//  StackOv (Errors module)
//
//  Created by Влад Климов
//  Copyright © 2021 Erik Basargin. All rights reserved.
//

import Foundation
import Network

public struct ServerError: Error {
    
    // MARK: - Properties
    
    public let type: HTTPStatusCode
    public let message: String
    
    // MARK: - Initialization
    
    public init?(_ error: Error) {
        guard let httpStatusCode = error as? HTTPStatusCode else {
            return nil
        }
        
        self.type = httpStatusCode

        switch httpStatusCode {
        case .notFound:
            self.message = "Request not found"
        case .badRequest:
            self.message = "The server cannot process the request"
        default:
            self.message = "Unknown error"
        }
    }
    
}
