#if !FRB_MATH_USE_SIMD

public struct QuaternionStorage<Value: StorageScalar>: QuaternionStorageProtocol {
    public typealias Element = Value

    @usableFromInline var storage: SIMD4<Value>

    public init(_ x: Value, _ y: Value, _ z: Value, _ w: Value) {
        self.init(SIMD4<Value>(x, y, z, w))
    }

    public init(_ vector: SIMD4<Value>) {
        storage = vector
    }

    @inlinable public var x: Value {
        get { storage.x }
        set { storage.x = newValue }
    }

    @inlinable public var y: Value {
        get { storage.y }
        set { storage.y = newValue }
    }

    @inlinable public var z: Value {
        get { storage.z }
        set { storage.z = newValue }
    }

    @inlinable public var w: Value {
        get { storage.w }
        set { storage.w = newValue }
    }

    public func makeIterator() -> SIMDScalarIterator<SIMD4<Value>> {
        storage.makeIterator()
    }
}

extension QuaternionStorage: Equatable {
    public static func == (lhs: QuaternionStorage<Value>, rhs: QuaternionStorage<Value>) -> Bool {
        lhs.storage == rhs.storage
    }
}

extension QuaternionStorage: @unchecked Sendable where Value: Sendable {}

#endif
