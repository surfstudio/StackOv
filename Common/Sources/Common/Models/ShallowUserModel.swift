//
//  ShallowUserModel.swift
//  StackOv (ShallowUserModel module)
//
//  Created by Владислав Климов
//  Copyright © 2021 Erik Basargin. All rights reserved.
//

import Foundation
import struct DataTransferObjects.ShallowUserEntry

public struct ShallowUserModel {
    
    // MARK: - Nested Types
    
    public enum UserType: String {
        case unregistered
        case registered
        case moderator
        case teamAdmin
        case doesNotExist
    }
    
    // MARK: - Properties
    
    public let reputation: Int?
    public let id: Int
    public let type: UserType?
    public let acceptRate: Int?
    public let avatar: URL?
    public let name: String
    public let link: URL?
}

// MARK: - Entry converter

public extension ShallowUserModel {
    
    static func from(entry: ShallowUserEntry) -> ShallowUserModel {
        ShallowUserModel(reputation: entry.reputation,
                         id: entry.id,
                         type: UserType(rawValue: entry.type.rawValue),
                         acceptRate: entry.acceptRate,
                         avatar: entry.avatar,
                         name: entry.name,
                         link: entry.link)
    }
    
}
