//
//  Cache.swift
//  StackOv (Common module)
//
//  Created by Erik Basargin
//  Copyright © 2021 Erik Basargin. All rights reserved.
//

import Foundation

/// https://www.swiftbysundell.com/articles/caching-in-swift/
public final class Cache<Key: Hashable, Value> {
    
    fileprivate let wrapped: NSCache<WrappedKey, Entry>
    
    public init() {
        self.wrapped = NSCache<WrappedKey, Entry>()
        self.wrapped.countLimit = 100
    }
    
    public subscript(key: Key) -> Value? {
        get { value(forKey: key) }
        set {
            guard let value = newValue else {
                removeValue(forKey: key)
                return
            }
            
            insert(value, forKey: key)
        }
    }
    
    public func insert(_ value: Value, forKey key: Key) {
        let entry = Entry(value: value)
        wrapped.setObject(entry, forKey: WrappedKey(key))
    }
    
    public func value(forKey key: Key) -> Value? {
        let entry = wrapped.object(forKey: WrappedKey(key))
        return entry?.value
    }
    
    public func removeValue(forKey key: Key) {
        wrapped.removeObject(forKey: WrappedKey(key))
    }
}

fileprivate extension Cache {
    
    final class WrappedKey: NSObject {
        let key: Key

        init(_ key: Key) {
            self.key = key
        }

        override var hash: Int { key.hashValue }

        override func isEqual(_ object: Any?) -> Bool {
            if let value = object as? WrappedKey {
                return value.key == key
            } else {
                return false
            }
        }
    }
    
    final class Entry {
        let value: Value
        
        init(value: Value) {
            self.value = value
        }
    }
}

