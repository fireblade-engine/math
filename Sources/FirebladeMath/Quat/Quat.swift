//
//  Quaternion.swift
//
//
//  Created by Christian Treffs on 06.09.19.
//

public struct Quaternion<Storage> where Storage: QuaternionStorageProtocol {
    public typealias Value = Storage.Value

    @usableFromInline var storage: Storage

    @inlinable public init(storage: Storage) {
        self.storage = storage
    }
}

extension Quaternion {
    /// Constructs a quaternion from a four-element vector.
    /// - Parameter vector: A four-element vector.
    ///
    /// Note that the imaginary (vector) part of the quaternion comes
    /// from lanes 0, 1, and 2 of the vector, and the real (scalar) part comes from
    /// lane 3.
    public init(_ vector: SIMD4<Value>) {
        self.init(storage: Storage(vector))
    }

    public init(_ x: Value, _ y: Value, _ z: Value, _ w: Value) {
        self.init(storage: Storage(x, y, z, w))
    }
}

extension Quaternion {
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
}

extension Quaternion: Sequence {
    public func makeIterator() -> IndexingIterator<[Storage.Value]> {
        unsafeBitCast(storage.makeIterator(), to: IndexingIterator<[Storage.Value]>.self)
    }

    @inlinable public var elements: [Value] {
        [Value](self)
    }
}

extension Quaternion: ExpressibleByArrayLiteral {
    public init(arrayLiteral elements: Value...) {
        precondition(elements.count == 4, "Quaternion needs to be initialized with exactly 4 elements")
        self.init(storage: Storage(elements[0], elements[1], elements[2], elements[3]))
    }
}

extension Quaternion: Equatable where Value: Equatable {
    public static func == (lhs: Quaternion<Storage>, rhs: Quaternion<Storage>) -> Bool {
        lhs.storage == rhs.storage
    }
}
