//
//  Lazy.swift
//  StackOv
//
//  Created by Erik Basargin on 20/05/2020.
//  Copyright © 2020 Ephedra Software. All rights reserved.
//

import Foundation

@propertyWrapper
enum Lazy<Value> {
    case uninitialized(() -> Value)
    case initialized(Value)
    
    init(wrappedValue: @autoclosure @escaping () -> Value) {
        self = .uninitialized(wrappedValue)
    }
    
    var wrappedValue: Value {
        mutating get {
            switch self {
            case .uninitialized(let initializer):
                let value = initializer()
                self = .initialized(value)
                return value
            case .initialized(let value):
                return value
            }
        }
        set {
            self = .initialized(newValue)
        }
    }
}

