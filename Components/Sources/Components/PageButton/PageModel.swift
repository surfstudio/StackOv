//
//  PageModel.swift
//  StackOv (Components module)
//
//  Created by Erik Basargin
//  Copyright © 2021 Erik Basargin. All rights reserved.
//

import Foundation

public struct PageModel: Identifiable {
    
    public let id: UUID
    public let title: String?
    
    public init(id: UUID = UUID(), title: String? = nil) {
        self.id = id
        self.title = title
    }
}
