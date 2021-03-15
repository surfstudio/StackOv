//
//  AuthManager.swift
//  StackOv (AuthManager module)
//
//  Created by Erik Basargin
//  Copyright © 2021 Erik Basargin. All rights reserved.
//

import Foundation
import AuthenticationServices
import Common
import Combine

#if canImport(AppKit) && !targetEnvironment(macCatalyst)
public typealias ASPresentationAnchor = NSWindow
#else
public typealias ASPresentationAnchor = UIWindow
#endif

final public class AuthManager: NSObject, ObservableObject, ASWebAuthenticationPresentationContextProviding {
    
    // MARK: - Nested types
    
    enum Constants {
        static let accessTokenKey = "access_token"
    }
    
    public enum Errors: Error {
        case unexpectedError
        case invalidAccessTokenUrl
        case accessTokenNotFound
    }
    
    // MARK: - Properties
    
    let configurations: StackexchangeAuthConfigurations
    var authProcess: AnyCancellable?
    
    // MARK: - Initialization and deinitialization
    
    public init(configurations: StackexchangeAuthConfigurations) {
        self.configurations = configurations
    }
    
    // MARK: - Public methods

    public func singIn() {
        authProcess?.cancel()
        authProcess = Future<URL, Error> { [unowned self] completion in
            let authUrl = configurations.getAuthUri(host: "stackoverflow.com")

            let authSession = ASWebAuthenticationSession(url: authUrl, callbackURLScheme: nil) { url, error in
                if let error = error {
                    completion(.failure(error))
                } else if let url = url {
                    completion(.success(url))
                } else {
                    completion(.failure(Errors.unexpectedError))
                }
            }
            authSession.presentationContextProvider = self
            authSession.prefersEphemeralWebBrowserSession = true
            authSession.start()
        }
        .tryMap { [unowned self] url in
            return try extractToken(fromUrl: url)
        }
        .sink { result in
            if case let .failure(error) = result {
                // show banner with error
                print(error)
            }
        } receiveValue: { accessToken in
            print(accessToken)
            // keep access_token in the keychain
        }
    }
    
    // MARK: - Internal methods
    
    func extractToken(fromUrl url: URL) throws -> String {
        guard url.absoluteString.hasPrefix(configurations.redirectUri.absoluteString),
              var components = URLComponents(url: url, resolvingAgainstBaseURL: true) else {
            throw Errors.invalidAccessTokenUrl
        }
        components.query = components.fragment
        components.fragment = nil
        if let accessToken = components.queryItems?.first(where: { $0.name == Constants.accessTokenKey })?.value {
            return accessToken
        }
        throw Errors.accessTokenNotFound
    }

    // MARK: - ASWebAuthenticationPresentationContextProviding
    
    @objc
    public func presentationAnchor(for session: ASWebAuthenticationSession) -> ASPresentationAnchor {
        return ASPresentationAnchor()
    }
}
