//
//  PersonInfoModel.swift
//  StackOv (Common module)
//
//  Created by Владислав Климов
//  Copyright © 2021 Erik Basargin. All rights reserved.
//

import Foundation

public struct UserModel {
    
    // MARK: - Nested Types
    
    public enum ActionType: String {
        case asked
        case edited
        case answered
    }
    
    // MARK: - Properties
    
    public let id: Int
    public let bronzeBadges: Int
    public let silverBadges: Int
    public let goldBadges: Int
    public let reputation: Int
    public let profileImage: URL
    public let displayName: String
    public let link: URL
    
    public let actionType: ActionType
    public let actionDate: Date

    public var formattedActionDate: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "d MMM, yyyy 'at' HH:mm"
        return dateFormatter.string(from: actionDate)
    }
    
    public var formattedReputationDate: String {
        String.roundNumberWithAbbreviations(number: reputation)
    }
    
    // MARK: - Public Methods
    
    public func formattedBagesNumber(number: Int) -> String {
        String.roundNumberWithAbbreviations(number: number)
    }
    
}

public extension UserModel {
    
    static func mock() -> UserModel {
        UserModel(id: 0,
                  bronzeBadges: 1001000,
                  silverBadges: 10,
                  goldBadges: 8,
                  reputation: 1000,
                  profileImage: URL(string: "https://www.gravatar.com/avatar/6d8ebb117e8d83d74ea95fbdd0f87e13?s=128&d=identicon&r=PG")!,
                  displayName: "John Wick",
                  link: URL(string: "http://example.stackexchange.com/users/1/example-user")!,
                  actionType: .asked,
                  actionDate: Date())
    }

}
