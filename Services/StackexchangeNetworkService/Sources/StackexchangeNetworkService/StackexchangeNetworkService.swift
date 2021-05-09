//
//  StackexchangeNetworkService.swift
//  StackOv (StackexchangeNetworkService module)
//
//  Created by Erik Basargin
//  Copyright © 2021 Erik Basargin. All rights reserved.
//

import Foundation
import Common
import Combine
import DataTransferObjects
import Errors
import struct os.Logger

public struct StackexchangeNetworkService {
    
    // MARK: - Nested types
    
    enum Constants {
        static let baseUrl = URL(string: "https://api.stackexchange.com/2.2")!
        static let quotaKey = "P8uUWwsGz2WbRs6)qHu)yw(("
    }
    
    // MARK: - Properties
    
    /// If you what customize the logger, see
    /// https://developer.apple.com/documentation/os/logging/generating_log_messages_from_your_code
    let logger = Logger()
    let decoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .secondsSince1970
        return decoder
    }()
    let session = URLSession(configuration: .default)
    private(set) var baseUrl: URL = Constants.baseUrl
    
    
    // MARK: - Initialization
    
    public init() {}
    
    // MARK: - Methods
    
    func getFilterQueryItem<Output: Decodable>(forOutput output: Output.Type) -> URLQueryItem? {
        switch output {
        case _ as AnswersEntry.Type:
            return URLQueryItem(name: "filter", value: "!*MeGkcG9287BD5-a")
        case _ as QuestionsEntry.Type:
            return URLQueryItem(name: "filter", value: "!T2q4lEgoRVrpJOn8R1")
        default:
            return nil
        }
    }
    
    // MARK: - Requests
     
    public func get<Output: Decodable>(_ urlString: String) -> AnyPublisher<Output, Error> {
        Just(urlString)
            .tryMap { urlString -> URL in
                guard var urlComponents = URLComponents(string: baseUrl.path + urlString) else {
                    throw ServiceError.url(code: URLError.badURL, urlString: urlString)
                }
                urlComponents.queryItems = [
                    URLQueryItem(name: "key", value: Constants.quotaKey),
                    URLQueryItem(name: "site", value: "stackoverflow"),
                    getFilterQueryItem(forOutput: Output.self),
                    URLQueryItem(name: "sort", value: "votes"),
                ].compactMap { $0 }
                guard let url = urlComponents.url(relativeTo: baseUrl) else {
                    throw ServiceError.urlComponents(urlComponents)
                }
                return url
            }
            .flatMap { url in
                session.dataTaskPublisher(for: url, logger: logger)
                    .catchHTTPError()
                    .map { $0.data }
            }
            .decode(type: Output.self, decoder: decoder)
            .eraseToAnyPublisher()
    }
}
