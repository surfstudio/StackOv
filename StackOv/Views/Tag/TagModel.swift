//
//  TagModel.swift
//  StackOv
//
//  Created by Erik Basargin on 08/05/2020.
//  Copyright © 2020 Ephedra Software. All rights reserved.
//

import Foundation
import UIKit

struct TagModel: Hashable, Identifiable {
    let name: String
    
    var id: Int { hashValue }
    
    var size: CGSize {
        let tagSize = (name as NSString).size(withAttributes: [.font: UIFont.systemFont(ofSize: 12)])
        return CGSize(width: ceil(12 + tagSize.width), height: ceil(9.6 + tagSize.height))
    }

    static func == (lhs: TagModel, rhs: TagModel) -> Bool {
        return lhs.hashValue == rhs.hashValue
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(name)
    }
}
