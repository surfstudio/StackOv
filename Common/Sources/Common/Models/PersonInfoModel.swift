//
//  PersonInfoModel.swift
//  StackOv (Common module)
//
//  Created by Владислав Климов
//  Copyright © 2021 Erik Basargin. All rights reserved.
//

import Foundation

public struct PersonInfoModel {
    
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
    public let profileImage: String
    public let displayName: String
    
    public let actionType: ActionType
    public let actionDate: Date

    public var formattedActionDate: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "d MMM, yyyy, 'at' HH:mm"
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

public extension PersonInfoModel {
    
    static func mock() -> PersonInfoModel {
        PersonInfoModel(id: 0,
                        bronzeBadges: 10000,
                        silverBadges: 10,
                        goldBadges: 8,
                        reputation: 100000,
                        profileImage: "https://www.gravatar.com/avatar/6d8ebb117e8d83d74ea95fbdd0f87e13?s=128&d=identicon&r=PG",
                        displayName: "John Wick",
                        actionType: .asked,
                        actionDate: Date())
    }

}
