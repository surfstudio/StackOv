//
//  PageDataManagerProtocol.swift
//  StackOv (PageStore module)
//
//  Created by Erik Basargin
//  Copyright © 2021 Erik Basargin. All rights reserved.
//

import Foundation

public protocol PageDataManagerProtocol: class {
    
    typealias CollectedData = [QuestionItemModel]
    typealias FetchComplitionHandler = (Result<CollectedData, Error>) -> Void
    
    var data: CollectedData? { get }
    var isLoading: Bool { get }
    var hasMoreData: Bool { get }
    
    func fetch(_ complitionHandler: @escaping FetchComplitionHandler)
    func reset()
}
