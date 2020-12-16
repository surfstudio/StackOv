//
//  PageModel.swift
//  This source file is part of the StackOv open source project
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
