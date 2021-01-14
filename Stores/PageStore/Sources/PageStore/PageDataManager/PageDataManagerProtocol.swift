//
//  PageDataManagerProtocol.swift
//  This source file is part of the StackOv open source project
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
