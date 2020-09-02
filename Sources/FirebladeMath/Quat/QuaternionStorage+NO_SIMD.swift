//
//  QuaternionStorage+NO_SIMD.swift
//
//
//  Created by Christian Treffs on 06.09.19.
//

#if !FRB_MATH_USE_SIMD

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
        get { storage.x }
    }

    @inlinable public var y: Value {
        set { storage.y = newValue }
        get { storage.y }
    }

    @inlinable public var z: Value {
        set { storage.z = newValue }
        get { storage.z }
    }

    @inlinable public var w: Value {
        set { storage.w = newValue }
        get { storage.w }
    }

    public __consuming func makeIterator() -> IndexingIterator<[Value]> {
        storage.makeIterator()
    }
}

extension QuaternionStorage: Equatable {
    public static func == (lhs: QuaternionStorage<Value>, rhs: QuaternionStorage<Value>) -> Bool {
        lhs.storage == rhs.storage
    }
}

#endif
