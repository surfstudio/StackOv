//
//  UserDTO.swift
//  StackOv
//
//  Created by Erik Basargin on 23/05/2020.
//  Copyright © 2020 Ephedra Software. All rights reserved.
//

import Foundation

typealias UserId = Int

enum UserType: String, Codable {
    case unregistered
    case registered
    case moderator
    case teamAdmin = "team_admin"
    case doesNotExist = "does_not_exist"
}

struct UserDTO: Codable {
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

