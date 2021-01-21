//
//  FilterOption.swift
//  This source file is part of the StackOv open source project
//

enum FilterOption: String, CaseIterable {    
    case noAnswers = "No answers"
    case noAcceptedAnswer = "No accepted answer"
    case hasBounty = "Has bounty"
}

extension FilterOption: Identifiable {
    
    var id: Int {
        hashValue
    }
}
