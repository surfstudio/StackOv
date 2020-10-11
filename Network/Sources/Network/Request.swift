//
//  Request.swift
//  
//
//  Created by Erik Basargin on 10/10/2020.
//

import Foundation
import Alamofire
import Combine

public protocol RequestProtocol {

    associatedtype Endpoint
    associatedtype Output
    
    var httpMethod: HTTPMethod { get }
    var urlMask: String { get }
    
    init(httpMethod: HTTPMethod,
         urlMask: String,
         headers: HTTPHeaders?,
         interceptor: RequestInterceptor?,
         requestModifier: Session.RequestModifier?)
}

public struct Request<Endpoint, Output>: RequestProtocol where Output: Decodable {
    
    public typealias Response = AnyPublisher<Output, NetworkError>
    
    public let httpMethod: HTTPMethod
    public let urlMask: String
    public let headers: HTTPHeaders?
    public let interceptor: RequestInterceptor?
    public let requestModifier: Session.RequestModifier?
    
    public init(httpMethod: HTTPMethod,
                urlMask: String,
                headers: HTTPHeaders? = nil,
                interceptor: RequestInterceptor? = nil,
                requestModifier: Session.RequestModifier? = nil) {
        self.httpMethod = httpMethod
        self.urlMask = urlMask
        self.headers = headers
        self.interceptor = interceptor
        self.requestModifier = requestModifier
    }
    
    public func prepare(headers: HTTPHeaders? = nil,
                        interceptor: RequestInterceptor? = nil,
                        requestModifier: Session.RequestModifier? = nil) -> Self {
        Self.init(
            httpMethod: httpMethod,
            urlMask: urlMask,
            headers: headers,
            interceptor: interceptor,
            requestModifier: requestModifier
        )
    }
    
    public func process(_ arguments: CVarArg...) -> Response {
        guard let urlString = String(format: urlMask, arguments: arguments).urlQueryAllowed else {
            return Fail(error: NetworkError.invalidURL(url: urlMask)).eraseToAnyPublisher()
        }
        return AF.request(
            urlString,
            method: httpMethod,
            headers: headers,
            interceptor: interceptor,
            requestModifier: requestModifier
        )
        .publishDecodable(type: Output.self)
        .value()
    }
    
    public func process<Parameters: Encodable>(parameters: Parameters?,
                                               encoder: ParameterEncoder = URLEncodedFormParameterEncoder.default,
                                               arguments: CVarArg...) -> Response {
        guard let urlString = String(format: urlMask, arguments: arguments).urlQueryAllowed else {
            return Fail(error: NetworkError.invalidURL(url: urlMask)).eraseToAnyPublisher()
        }
        return AF.request(
            urlString,
            method: httpMethod,
            parameters: parameters,
            encoder: encoder,
            headers: headers,
            interceptor: interceptor,
            requestModifier: requestModifier
        )
        .publishDecodable(type: Output.self)
        .value()
    }
}
