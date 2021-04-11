//
//  Request.swift
//  StackOv (Network module)
//
//  Created by Erik Basargin
//  Copyright © 2021 Erik Basargin. All rights reserved.
//

import Foundation

public protocol RequestProtocol {

    associatedtype Endpoint
    associatedtype Output
    
    var httpMethod: String { get }
    var urlMask: String { get }
    var cachePolicy: URLRequest.CachePolicy { get }
    var timeoutInterval: TimeInterval { get }

    init(httpMethod: String,
         urlMask: String,
         cachePolicy: URLRequest.CachePolicy,
         timeoutInterval: TimeInterval)
    
    func buildURL(arguments: [CVarArg]) throws -> URL
    func buildURLRequest(byURL url: URL) throws -> URLRequest
    func buildURLRequest(arguments: [CVarArg]) throws -> URLRequest
    func buildURLRequest(parameters: [URLQueryItem], arguments: [CVarArg]) throws -> URLRequest
    
}

public struct Request<Endpoint, Output>: RequestProtocol where Output: Decodable {
    
    // MARK: - Nested types
    
    public enum Errors: Error {
        case invalidURLString(urlString: String)
        case invalidURLComponents(urlComponents: URLComponents)
        case percentEncoding(urlString: String, allowedCharacters: CharacterSet)
    }
    
    // MARK: - Public properties
    
    public let httpMethod: String
    public let urlMask: String
    public let cachePolicy: URLRequest.CachePolicy
    public let timeoutInterval: TimeInterval
    
    // MARK: - Initialization

    public init(httpMethod: String,
                urlMask: String,
                cachePolicy: URLRequest.CachePolicy,
                timeoutInterval: TimeInterval) {
        self.httpMethod = httpMethod
        self.urlMask = urlMask
        self.cachePolicy = cachePolicy
        self.timeoutInterval = timeoutInterval
    }
    
    // MARK: - Public methods
    
    public func buildURL(arguments: [CVarArg]) throws -> URL {
        (try buildURLComponents(arguments: arguments).url)!
    }
    
    public func buildURLRequest(byURL url: URL) throws -> URLRequest {
        var request = URLRequest(url: url, cachePolicy: cachePolicy, timeoutInterval: timeoutInterval)
        request.httpMethod = httpMethod
        return request
    }

    public func buildURLRequest(arguments: [CVarArg]) throws -> URLRequest {
        try buildURLRequest(byURL: try buildURL(arguments: arguments))
    }
    
    public func buildURLRequest(parameters: [URLQueryItem], arguments: [CVarArg]) throws -> URLRequest {
        var urlComponents = try buildURLComponents(arguments: arguments)
        urlComponents.queryItems = (urlComponents.queryItems ?? []) + parameters
        guard let url = urlComponents.url else {
            throw Errors.invalidURLComponents(urlComponents: urlComponents)
        }
        return try buildURLRequest(byURL: url)
    }
        
    // MARK: - Internal methods
    
    func buildURLComponents(arguments: [CVarArg]) throws -> URLComponents {
        let urlString = String(format: urlMask, arguments: arguments)
        guard let preparedURL = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {
            throw Errors.percentEncoding(urlString: urlString, allowedCharacters: .urlQueryAllowed)
        }
        guard let urlComponents = URLComponents(string: preparedURL) else {
            throw Errors.invalidURLString(urlString: preparedURL)
        }
        return urlComponents
    }

}
