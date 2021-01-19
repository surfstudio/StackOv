//
//  MethodWrapping.swift
//  This source file is part of the StackOv open source project
//

import Foundation
import Common

public class MethodWrapping<Request, Endpoint, Output> where Request: RequestProtocol, Request.Output == Output, Request.Endpoint == Endpoint {
    
    @Lazy internal var request: Request!
    
    internal lazy var method: String = {
        let typeName = "\(type(of: self))"
        guard let objectName = typeName.split(separator: "<").first else {
            return typeName
        }
        return String(objectName)
    }()
    
    public init(_ urlMask: String,
                cachePolicy: URLRequest.CachePolicy = .useProtocolCachePolicy,
                timeoutInterval: TimeInterval = 60.0) {
        request = Request(
            httpMethod: method,
            urlMask: urlMask,
            cachePolicy: cachePolicy,
            timeoutInterval: timeoutInterval
        )
    }
    
    public init(_ baseUrl: String,
                _ urlMask: String,
                cachePolicy: URLRequest.CachePolicy = .useProtocolCachePolicy,
                timeoutInterval: TimeInterval = 60.0) {
        let urlString = baseUrl.dropLastSlash() + "/" + urlMask.dropFirstSlash()
        request = Request(
            httpMethod: method,
            urlMask: urlString,
            cachePolicy: cachePolicy,
            timeoutInterval: timeoutInterval
        )
    }
    
    public init(_ baseUrl: URL,
                _ urlMask: String,
                cachePolicy: URLRequest.CachePolicy = .useProtocolCachePolicy,
                timeoutInterval: TimeInterval = 60.0) {
        let urlString = baseUrl.absoluteString.dropLastSlash() + "/" + urlMask.dropFirstSlash()
        request = Request(
            httpMethod: method,
            urlMask: urlString,
            cachePolicy: cachePolicy,
            timeoutInterval: timeoutInterval
        )
    }
}

// MARK: - Extensions

fileprivate extension String {
    
    func dropFirstSlash() -> Self {
        self.first == "/" ? String(self.dropFirst()) : self
    }
    func dropLastSlash() -> Self {
        self.last == "/" ? String(self.dropLast()) : self
    }
}
