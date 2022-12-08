//
//  Matrix2x2.swift
//
//
//  Created by stackotter on 01.11.22.
//

@frozen
public struct Matrix2x2<Storage>: RandomAccessCollection, MutableCollection where Storage: Storage2x2Protocol, Storage.Value == Storage.Element {
    public typealias Element = Storage.Element
    public typealias Index = Storage.Index
    public typealias Value = Storage.Value
    public typealias Vector = Storage.Column

    @usableFromInline var storage: Storage

    public var startIndex: Index { storage.startIndex }
    public var endIndex: Index { storage.endIndex }
    public func index(after i: Index) -> Index { storage.index(after: i) }
    public func index(before i: Index) -> Index { storage.index(before: i) }

    @usableFromInline init(storage: Storage) {
        self.storage = storage
    }

    public init(diagonal: Vector) {
        self.storage = Storage(diagonal: diagonal)
    }

    public init(_ columns: [Vector]) {
        precondition(columns.count == 2, "Matrix needs exactly 2 Vector vectors")
        self.storage = Storage(columns)
    }

    public init(_ column0: Vector, _ column1: Vector) {
        self.init([column0, column1])
    }

    public init(_ values: [Storage.Value]) {
        precondition(values.count == 4, "Matrix needs exactly 4 values")
        self.init([Vector(values[0...1]),
                   Vector(values[2...3])])
    }

    public subscript(index: Index) -> Element {
        get { storage[index] }
        set { storage[index] = newValue }
    }

    public subscript(column: Int, row: Int) -> Value {
        get { storage[column, row] }
        set { storage[column, row] = newValue }
    }

    @inlinable public var columns: (Vector, Vector) {
        storage.columns
    }

    @inlinable public var elements: [Value] {
        [Value](AnyIterator(self.storage.makeIterator()))
    }

    @inlinable public func withForcedContiguousStorage<R>(_ body: (UnsafeBufferPointer<Element>) -> R) throws -> R? {
        // https://forums.swift.org/t/se-0256-introduce-mutable-contiguouscollection-protocol/22569/7
        if let result = withContiguousStorageIfAvailable(body) {
            return result
        }

        return ContiguousArray(self).withContiguousStorageIfAvailable(body)
    }

    @inlinable public mutating func withForcedContiguousMutableStorage<R>(_ body: (inout UnsafeMutableBufferPointer<Element>) -> R) throws -> R? {
        // https://forums.swift.org/t/se-0256-introduce-mutable-contiguouscollection-protocol/22569/7
        if let result = withContiguousMutableStorageIfAvailable(body) {
            return result
        }

        var array = ContiguousArray(self)
        let result = array.withContiguousMutableStorageIfAvailable(body)
        for (idx, arrayIdx) in zip(self.indices, array.indices) {
            self[idx] = array[arrayIdx]
        }
        return result
    }
}

extension Matrix2x2: Equatable {
    public static func ==(lhs: Matrix2x2<Storage>, rhs: Matrix2x2<Storage>) -> Bool {
        lhs.storage == rhs.storage
    }
}
