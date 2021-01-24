//
//  DataTaskPublisher.swift
//  StackOv (Network module)
//
//  Created by Erik Basargin
//  Copyright © 2021 Erik Basargin. All rights reserved.
//

import Foundation
import Combine

@available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
public extension URLSession.DataTaskPublisher {
    
    enum Errors: Error {
        case invalidResponse(URLResponse)
        case unknownHTTPCode(response: HTTPURLResponse)
    }

    func tryCatchHTTPError() -> Publishers.TryMap<Self, Self.Output> {
        return tryMap { (data: Data, response: URLResponse) in
            guard let httpResponse = response as? HTTPURLResponse else {
                throw Errors.invalidResponse(response)
            }
            guard let httpStatus = httpResponse.status else {
                throw Errors.unknownHTTPCode(response: httpResponse)
            }
            switch httpStatus.responseType {
            case .success:
                return (data, response)
            default:
                throw httpStatus
            }
        }
    }
}

