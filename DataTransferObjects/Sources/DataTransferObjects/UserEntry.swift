//
//  UserEntry.swift
//  StackOv (DataTransferObjects module)
//
//  Created by Erik Basargin
//  Copyright © 2021 Erik Basargin. All rights reserved.
//

import Foundation

public struct UserEntry: Codable {
    
    // MARK: - Nested types
    
    public enum CodingKeys: String, CodingKey {
        case reputation
        case id = "user_id"
        case type = "user_type"
        case acceptRate = "accept_rate"
        case avatar = "profile_image"
        case name = "display_name"
        case link
    }
    
    public enum UserType: String, Codable {
        case unregistered
        case registered
        case moderator
        case teamAdmin = "team_admin"
        case doesNotExist = "does_not_exist"
    }
    
    // MARK: - Public properties
    
    public let reputation: Int?
    public let id: Int?
    public let type: UserType
    public let acceptRate: Int?
    public let avatar: URL?
    public let name: String
    public let link: URL?
}


