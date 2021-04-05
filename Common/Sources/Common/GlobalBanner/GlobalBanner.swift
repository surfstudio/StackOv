//
//  NotificationBannerData.swift
//  StackOv (Components module)
//
//  Created by Владислав Климов
//  Copyright © 2021 Erik Basargin. All rights reserved.
//

import Foundation
import Combine
import Errors

public enum GlobalBanner {
    
    // MARK: - Neasted types
    
    public typealias Style = NotificationBannerStyle
    public typealias Model = NotificationBannerModel
    
    // MARK: - Public properties
    
    public static var publisher: AnyPublisher<Model, Never> { sender.eraseToAnyPublisher() }
    
    // MARK: - Interlnal properties

    static let sender = PassthroughSubject<Model, Never>()
    
    // MARK: - Public methods
    
    public static func show(data: Model) {
        sender.send(data)
    }
    
    public static func show(error: Error) {
        guard let error = error as? DisplaybleError else { return }
        sender.send(error.toGlobalBannerModel)
    }
}

fileprivate extension DisplaybleError {
    
    var toGlobalBannerModel: GlobalBanner.Model {
        .init(title: title, description: description, style: .error)
    }
}
