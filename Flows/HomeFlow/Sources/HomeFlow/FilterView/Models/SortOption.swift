//
//  SortOption.swift
//  StackOv (HomeFlow module)
//
//  Created by Evgeny Novgorodov
//  Copyright © 2021 Erik Basargin. All rights reserved.
//

enum SortOption: String, CaseIterable {
    case newest = "Newest"
    case recentActivity = "Recent activity"
    case mostVotes = "Most votes"
    case bountyEditingSoon = "Bounty editing soon"
}

extension SortOption: Identifiable {
    
    var id: Int {
        hashValue
    }
}
