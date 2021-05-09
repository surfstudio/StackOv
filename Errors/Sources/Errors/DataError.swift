//
//  DataError.swift
//  StackOv (Errors module)
//
//  Created by  Erik Basargin
//  Copyright © 2021 Erik Basargin. All rights reserved.
//

import Foundation

public enum DataError: Error {
    case wrongEncoding(data: Data, encoding: String.Encoding)
}
