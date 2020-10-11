//
//  MethodWrapping.swift
//  
//
//  Created by Erik Basargin on 10/10/2020.
//

import Foundation
import Alamofire
import Common

public class MethodWrapping<Request, Endpoint, Output> where Request: RequestProtocol, Request.Output == Output, Request.Endpoint == Endpoint {
    
    @Lazy internal var request: Request!
    
    internal lazy var method: HTTPMethod = {
        let typeName = "\(type(of: self))"
        guard let objectName = typeName.split(separator: "<").first else {
            return HTTPMethod(rawValue: typeName)
        }
        return HTTPMethod(rawValue: String(objectName))
    }()
    
    public init(_ urlMask: String) {
        request = Request(
            httpMethod: method,
            urlMask: urlMask,
            headers: nil,
            interceptor: nil,
            requestModifier: nil
        )
    }
    
    public init(_ baseUrl: String, _ urlMask: String) {
        let urlString = baseUrl.dropLastSlash() + "/" + urlMask.dropFirstSlash()
        request = Request(
            httpMethod: method,
            urlMask: urlString,
            headers: nil,
            interceptor: nil,
            requestModifier: nil
        )
    }
    
    public init(_ baseUrl: URL, _ urlMask: String) {
        let urlString = baseUrl.absoluteString.dropLastSlash() + "/" + urlMask.dropFirstSlash()
        request = Request(
            httpMethod: method,
            urlMask: urlString,
            headers: nil,
            interceptor: nil,
            requestModifier: nil
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
