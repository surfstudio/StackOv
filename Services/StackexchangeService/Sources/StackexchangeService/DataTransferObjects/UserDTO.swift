//
//  UserDTO.swift
//  
//
//  Created by Erik Basargin on 10/10/2020.
//

import Foundation

public typealias UserId = Int

public enum UserType: String, Codable {
    case unregistered
    case registered
    case moderator
    case teamAdmin = "team_admin"
    case doesNotExist = "does_not_exist"
}

public struct UserDTO: Codable {
    
    enum CodingKeys: String, CodingKey {
        case reputation
        case id = "user_id"
        case type = "user_type"
        case acceptRate = "accept_rate"
        case avatar = "profile_image"
        case name = "display_name"
        case link
    }
    
    let reputation: Int?
    let id: UserId?
    let type: UserType
    let acceptRate: Int?
    let avatar: URL?
    let name: String
    let link: URL?
}


