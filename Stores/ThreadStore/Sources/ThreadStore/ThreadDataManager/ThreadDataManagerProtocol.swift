//
//  ThreadDataManagerProtocol.swift
//  StackOv (ThreadStore module)
//
//  Created by Влад Климов
//  Copyright © 2021 Erik Basargin. All rights reserved.
//

import Foundation
import Common

public protocol ThreadDataManagerProtocol {
    
    typealias CollectedData = [AnswerModel]
    typealias ResultHandler = (Result<CollectedData, Error>) -> Void
    
    var data: CollectedData? { get }
    var isLoading: Bool { get }
    var hasMoreData: Bool { get }
    
    func load(by id: Int, receiveCompletion: @escaping ResultHandler)
    func fetch(questionId: Int, receiveCompletion: @escaping ResultHandler)
    func reload(questionId: Int, receiveCompletion: @escaping ResultHandler)
    func reload(acceptedId: Int, receiveCompletion: @escaping ResultHandler)
    func reset()
}
