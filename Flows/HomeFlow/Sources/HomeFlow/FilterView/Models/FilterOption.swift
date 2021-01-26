//
//  FilterOption.swift
//  StackOv (HomeFlow module)
//
//  Created by Evgeny Novgorodov
//  Copyright © 2021 Erik Basargin. All rights reserved.
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
