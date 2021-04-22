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

public struct StackexchangeNetworkService {
    
    // MARK: - Nested types
    
    enum Constants {
        static let baseUrl = URL(string: "https://api.stackexchange.com/2.2")!
        static let questionsFilter = "!aihcQYcFVbLExG" //"!gB66lk5yFs_jDNjfXUw05bhJZ(a*QmeMZkH" //"!*7PZ(S77sKA3Rc8i4h4)QI0bM8HG"
        static let questionFilter = "!PvyfxTBzonJRcqwIa*BHYvqSvHDWMY"
        static let answerFilter = "!3tp2yiVOGrYbU8opi"//"!3xJkL2qoqNZw7Litv"
        static let quotaKey = "P8uUWwsGz2WbRs6)qHu)yw(("
    }
    
    // MARK: - Properties
    
    let decoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .secondsSince1970
        return decoder
    }()
    let session = URLSession(configuration: .default)
    private(set) var baseUrl: URL = Constants.baseUrl
    
    
    // MARK: - Initialization
    
    public init() {}
    
    // MARK: - Requests
     
    public func get<Output: Decodable>(_ urlString: String) -> AnyPublisher<Output, Error> {
        Just(urlString)
            .tryMap { urlString -> URL in
                guard var urlComponents = URLComponents(string: urlString) else {
                    throw ServiceError.url(code: URLError.badURL, urlString: urlString)
                }
                urlComponents.queryItems = [
                    URLQueryItem(name: "key", value: StackexchangeNetworkService.Constants.quotaKey),
                    URLQueryItem(name: "site", value: "stackoverflow")
                ]
                guard let url = urlComponents.url(relativeTo: baseUrl) else {
                    throw ServiceError.urlComponents(urlComponents)
                }
                return url
            }
            .flatMap { url in
                session.dataTaskPublisher(for: url)
                    .catchHTTPError()
                    .map { $0.data }
            }
            .decode(type: Output.self, decoder: decoder)
            .eraseToAnyPublisher()
    }
}
