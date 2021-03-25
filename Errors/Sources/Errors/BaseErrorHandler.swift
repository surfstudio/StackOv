//
//  BaseErrorHandler.swift
//  StackOv (Errors module)
//
//  Created by Владислав Климов
//  Copyright © 2021 Erik Basargin. All rights reserved.
//

import Foundation

public class BaseErrorHandler {

    // MARK: - Initialization

    public init() {}

    // MARK: - Public Methods

    public func handleError(error: Error) -> String {
        guard let serverError = ServerError(error) else {
            return "Unknown error"
        }

        return serverError.message
    }

}
