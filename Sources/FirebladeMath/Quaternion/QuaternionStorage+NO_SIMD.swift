//
//  QuaternionStorage+NO_SIMD.swift
//
//
//  Created by Christian Treffs on 06.09.19.
//

#if !USE_SIMD

public struct QuaternionStorage<Value>: QuaternionStorageProtocol where Value: StorageScalar {
    @usableFromInline var storage: SIMD4<Value>

    public init(_ x: Value, _ y: Value, _ z: Value, _ w: Value) {
        self.init(SIMD4<Value>(x, y, z, w))
    }

    public init(_ vector: SIMD4<Value>) {
        storage = vector
    }

    @inlinable public var x: Value {
        set { storage.x = newValue }
        get { return storage.x }
    }

    @inlinable public var y: Value {
        set { storage.y = newValue }
        get { return storage.y }
    }

    @inlinable public var z: Value {
        set { storage.z = newValue }
        get { return storage.z }
    }

    @inlinable public var w: Value {
        set { storage.w = newValue }
        get { return storage.w }
    }

    public __consuming func makeIterator() -> IndexingIterator<[Value]> {
        return storage.makeIterator()
    }
}

extension QuaternionStorage: Equatable {
    public static func == (lhs: QuaternionStorage<Value>, rhs: QuaternionStorage<Value>) -> Bool {
        return lhs.storage == rhs.storage
    }
}

#endif
