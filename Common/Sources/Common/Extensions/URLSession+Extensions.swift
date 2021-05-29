//
//  DataTaskPublisher.swift
//  StackOv (Network module)
//
//  Created by Erik Basargin
//  Copyright © 2021 Erik Basargin. All rights reserved.
//

import Foundation
import Combine
import Errors
import struct os.Logger

public extension Publisher where Output == URLSession.DataTaskPublisher.Output {
    
    func catchHTTPError() -> Publishers.TryMap<Self, Self.Output> {
        return tryMap { (data: Data, response: URLResponse) in
            guard let httpResponse = response as? HTTPURLResponse else {
                throw URLSessionError.invalidResponse(response)
            }
            guard let httpStatus = httpResponse.status else {
                throw URLSessionError.unknownHTTPCode(response: httpResponse)
            }
            switch httpStatus.responseType {
            case .success:
                return (data, response)
            default:
                throw HTTPError(httpStatus) ?? httpStatus
            }
        }
    }
}

public extension URLSession.DataTaskPublisher {
    
    func log(with logger: Logger) -> AnyPublisher<Self.Output, Error> {
        return tryMap { (data: Data, response: URLResponse) in
            var responseString: String = ""
            debugPrint(response, to: &responseString)
            
            var dataString: String = ""
            debugPrint(data, to: &dataString)
            // If you want to see full body of the request, for some reason, you could use next code:
            //
            // if let value = (try? data.toJsonString(options: .prettyPrinted)) ?? String(data: data, encoding: .utf8) {
            //     dataString = value
            // } else {
            //     debugPrint(data, to: &dataString)
            // }
            
            logger.debug("""
            \n[Request]
            \(request.httpMethod ?? "") \(request)
            [Response]
            \(responseString)
            [Data]
            \(dataString)
            """)
            return (data, response)
        }.eraseToAnyPublisher()
    }
}

public extension URLSession {
    
    func dataTaskPublisher(for request: URLRequest, logger: Logger) -> AnyPublisher<DataTaskPublisher.Output, Error> {
        logger.debug("\n[Request] \(request.httpMethod ?? "") \(request)")
        return dataTaskPublisher(for: request).log(with: logger)
    }
    
    func dataTaskPublisher(for url: URL, logger: Logger) -> AnyPublisher<DataTaskPublisher.Output, Error> {
        logger.debug("\n[Request] GET \(url.absoluteString)")
        return dataTaskPublisher(for: url).log(with: logger)
    }
}
