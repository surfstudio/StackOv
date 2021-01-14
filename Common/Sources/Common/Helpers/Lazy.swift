//
//  Lazy.swift
//  This source file is part of the StackOv open source project
//

import Foundation

@propertyWrapper public enum Lazy<Value> {
    
    case uninitialized(() -> Value)
    case initialized(Value)
    
    public init(wrappedValue: @autoclosure @escaping () -> Value) {
        self = .uninitialized(wrappedValue)
    }
    
    public var wrappedValue: Value {
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
