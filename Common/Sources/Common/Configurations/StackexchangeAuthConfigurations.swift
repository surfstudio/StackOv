//
//  StackexchangeAuthConfigurations.swift
//  StackOv (Common module)
//
//  Created by Erik Basargin
//  Copyright © 2021 Erik Basargin. All rights reserved.
//

import Foundation
import URLBuilder

public final class StackexchangeAuthConfigurations: Codable {
    
    // MARK: - Nested types
    
    public enum CodingKeys: String, CodingKey {
        case clientId = "client_id"
        case scope
        case redirectUri = "redirect_uri"
    }
    
    public enum Errors: Error {
        case confFileNotFound
    }
    
    // MARK: - Public properties
    
    public let clientId: Int
    public let scope: String
    public let redirectUri: URL
    
    // MARK: - Public methods
    
    public static func load() throws -> Self {
        guard let filePath = Bundle.module.url(forResource: "\(Self.self)", withExtension: "json") else {
            throw Errors.confFileNotFound
        }
        let data = try Data(contentsOf: filePath)
        let object = try JSONDecoder().decode(Self.self, from: data)
        return object
    }
    
    public func getAuthUri(host: String) -> URL {
        URLBuilder.scheme(.https)
            .host(custom: host)
            .path(custom: "/oauth/dialog")
            .query(items: [
                (CodingKeys.clientId.rawValue, "\(clientId)"),
                (CodingKeys.scope.rawValue, scope),
                (CodingKeys.redirectUri.rawValue, redirectUri.absoluteString)
            ])
            .url!
    }
}
