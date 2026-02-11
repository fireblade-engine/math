/// A protocol that defines the storage requirements for a 4x4 matrix.
public protocol Storage4x4Protocol: RandomAccessCollection, MutableCollection, RangeReplaceableCollection, Equatable, Sendable {
    /// The scalar type used in the matrix.
    associatedtype Value: StorageScalar
    /// associatedtype _Storage3x3: Storage3x3Protocol where _Storage3x3.Value == Value
    /// The column vector type.
    typealias Column = SIMD4<Value>

    /// Creates a new storage from an array of column vectors.
    init(_ columns: [Column])
    /// Creates a new storage with the specified diagonal values.
    init(diagonal: Column)

    // swiftlint:disable large_tuple
    /// The column vectors of the matrix.
    var columns: (Column, Column, Column, Column) { get }

    /// Accesses the value at the specified column and row.
    subscript(column: Int, row: Int) -> Value { get set }
    /// Accesses the value at the specified flat index in column-major order.
    subscript(index: Int) -> Value { get set }
}

extension Storage4x4Protocol where Element == Value, Index == Int {
    /// The start index (0).
    public var startIndex: Int {
        0
    }

    /// The end index (16).
    public var endIndex: Int {
        16
    }

    /// Returns the index after the given index.
    public func index(after i: Int) -> Int {
        i + 1
    }
}

extension Storage4x4Protocol {
    /// Replaces a subrange of the matrix's underlying storage.
    /// - Precondition: `subrange` and `newElements` must be the same length because if they don't
    ///   that doesn't make any sense in relation to matrices.
    public mutating func replaceSubrange<C: Collection>(_ subrange: Range<Int>, with newElements: C) where Value == C.Element {
        precondition(subrange.count == newElements.count, "newElements must be the same length as subrange")

        for (i, element) in zip(subrange, newElements) {
            self[i] = element
        }
    }
}

/// A protocol that defines the storage requirements for a 3x3 matrix.
public protocol Storage3x3Protocol: RandomAccessCollection, MutableCollection, RangeReplaceableCollection, Equatable, Sendable {
    /// The scalar type used in the matrix.
    associatedtype Value: StorageScalar
    /// associatedtype _Storage4x4: Storage4x4Protocol where _Storage4x4.Value == Value
    /// The column vector type.
    typealias Column = SIMD3<Value>

    /// Creates a new storage from an array of column vectors.
    init(_ columns: [Column])
    /// Creates a new storage with the specified diagonal values.
    init(diagonal: Column)

    /// The column vectors of the matrix.
    var columns: (Column, Column, Column) { get }

    /// Accesses the value at the specified column and row.
    subscript(column: Int, row: Int) -> Value { get set }
    /// Accesses the value at the specified flat index in column-major order.
    subscript(index: Int) -> Value { get set }
}

extension Storage3x3Protocol where Element == Value, Index == Int {
    /// The start index (0).
    public var startIndex: Int {
        0
    }

    /// The end index (9).
    public var endIndex: Int {
        9
    }

    /// Returns the index after the given index.
    public func index(after i: Int) -> Int {
        i + 1
    }
}

extension Storage3x3Protocol {
    /// Replaces a subrange of the matrix's underlying storage.
    /// - Precondition: `subrange` and `newElements` must be the same length because if they don't
    ///   that doesn't make any sense in relation to matrices.
    public mutating func replaceSubrange<C: Collection>(_ subrange: Range<Int>, with newElements: C) where Value == C.Element {
        precondition(subrange.count == newElements.count, "newElements must be the same length as subrange")

        for (i, element) in zip(subrange, newElements) {
            self[i] = element
        }
    }
}

/// A protocol that defines the storage requirements for a 2x2 matrix.
public protocol Storage2x2Protocol: RandomAccessCollection, MutableCollection, RangeReplaceableCollection, Equatable, Sendable {
    /// The scalar type used in the matrix.
    associatedtype Value: StorageScalar
    /// associatedtype _Storage4x4: Storage4x4Protocol where _Storage4x4.Value == Value
    /// The column vector type.
    typealias Column = SIMD2<Value>

    /// Creates a new storage from an array of column vectors.
    init(_ columns: [Column])
    /// Creates a new storage with the specified diagonal values.
    init(diagonal: Column)

    /// The column vectors of the matrix.
    var columns: (Column, Column) { get }

    /// Accesses the value at the specified column and row.
    subscript(column: Int, row: Int) -> Value { get set }
    /// Accesses the value at the specified flat index in column-major order.
    subscript(index: Int) -> Value { get set }
}

extension Storage2x2Protocol where Element == Value, Index == Int {
    /// The start index (0).
    public var startIndex: Int {
        0
    }

    /// The end index (4).
    public var endIndex: Int {
        4
    }

    /// Returns the index after the given index.
    public func index(after i: Int) -> Int {
        i + 1
    }
}

extension Storage2x2Protocol {
    /// Replaces a subrange of the matrix's underlying storage.
    /// - Precondition: `subrange` and `newElements` must be the same length because if they don't
    ///   that doesn't make any sense in relation to matrices.
    public mutating func replaceSubrange<C: Collection>(_ subrange: Range<Int>, with newElements: C) where Value == C.Element {
        precondition(subrange.count == newElements.count, "newElements must be the same length as subrange")

        for (i, element) in zip(subrange, newElements) {
            self[i] = element
        }
    }
}
