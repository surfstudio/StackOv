//
//  Wrappers.swift
//  StackOv (AppScript module)
//
//  Created by Erik Basargin
//  Copyright © 2021 Erik Basargin. All rights reserved.
//

import struct SwiftUI.ObservedObject
import protocol SwiftUI.ObservableObject
import protocol SwiftUI.DynamicProperty

@available(iOS 14.0, macOS 11.0, tvOS 14.0, watchOS 7.0, *)
@propertyWrapper public struct Store<ObjectType: ObservableObject>: DynamicProperty {
    
    // MARK: - Initialization
    
    public init(name: String? = nil) {
        self.object = StoresAssembler.shared.resolve(ObjectType.self, name: name)!
    }
    
    // MARK: - Internal properties
    
    @ObservedObject var object: ObjectType = StoresAssembler.shared.resolve(ObjectType.self)!
    
    // MARK: - Public properties
    
    public var wrappedValue: ObjectType { object }
    public var projectedValue: ObservedObject<ObjectType>.Wrapper { $object }
}
