//
//  HTTPWrappers.swift
//  StackOv (Network module)
//
//  Created by Erik Basargin
//  Copyright © 2021 Erik Basargin. All rights reserved.
//

import Foundation

// MARK: - GET Wrapper

@propertyWrapper
public final class GET<Request, Endpoint, Output>: MethodWrapping<Request, Endpoint, Output> where Request: RequestProtocol, Request.Output == Output, Request.Endpoint == Endpoint {
    public var wrappedValue: Request { request }
}

// MARK: - POST Wrapper

@propertyWrapper
public final class POST<Request, Endpoint, Output>: MethodWrapping<Request, Endpoint, Output> where Request: RequestProtocol, Request.Output == Output, Request.Endpoint == Endpoint {
    public var wrappedValue: Request { request }
}

// MARK: - PUT Wrapper

@propertyWrapper
public final class PUT<Request, Endpoint, Output>: MethodWrapping<Request, Endpoint, Output> where Request: RequestProtocol, Request.Output == Output, Request.Endpoint == Endpoint {
    public var wrappedValue: Request { request }
}

// MARK: - PATCH Wrapper

@propertyWrapper
public final class PATCH<Request, Endpoint, Output>: MethodWrapping<Request, Endpoint, Output> where Request: RequestProtocol, Request.Output == Output, Request.Endpoint == Endpoint {
    public var wrappedValue: Request { request }
}

// MARK: - DELETE Wrapper

@propertyWrapper
public final class DELETE<Request, Endpoint, Output>: MethodWrapping<Request, Endpoint, Output> where Request: RequestProtocol, Request.Output == Output, Request.Endpoint == Endpoint {
    public var wrappedValue: Request { request }
}
