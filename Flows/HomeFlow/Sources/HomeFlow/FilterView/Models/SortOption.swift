//
//  SortOption.swift
//  This source file is part of the StackOv open source project
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
