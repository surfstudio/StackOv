//
//  TagModel.swift
//  StackoverflowIOS
//
//  Created by Erik Basargin on 08/05/2020.
//  Copyright © 2020 Ephedra Software. All rights reserved.
//

import Foundation

struct TagModel: Hashable, Identifiable {
    let name: String
    
    var id: Int { hashValue }
    
    static func == (lhs: TagModel, rhs: TagModel) -> Bool {
        return lhs.hashValue == rhs.hashValue
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(name)
    }
}
