//
//  QuaternionStorage+NO_SIMD.swift
//
//
//  Created by Christian Treffs on 06.09.19.
//

#if !USE_SIMD

public struct QuaternionStorage<Value>: QuaternionStorageProtocol where Value: StorageScalar {
    @usableFromInline var _storage: SIMD4<Value>

    public init(_ x: Value, _ y: Value, _ z: Value, _ w: Value) {
        self.init(SIMD4<Value>(x, y, z, w))
    }

    public init(_ vector: SIMD4<Value>) {
        _storage = vector
    }

    @inlinable public var x: Value {
        set { _storage.x = newValue }
        get { _storage.x }
    }

    @inlinable public var y: Value {
        set { _storage.y = newValue }
        get { _storage.y }
    }

    @inlinable public var z: Value {
        set { _storage.z = newValue }
        get { _storage.z }
    }

    @inlinable public var w: Value {
        set { _storage.w = newValue }
        get { _storage.w }
    }

    public __consuming func makeIterator() -> IndexingIterator<[Value]> {
        return _storage.makeIterator()
    }
}

extension QuaternionStorage: Equatable {
    public static func == (lhs: QuaternionStorage<Value>, rhs: QuaternionStorage<Value>) -> Bool {
        return lhs._storage == rhs._storage
    }
}

#endif
