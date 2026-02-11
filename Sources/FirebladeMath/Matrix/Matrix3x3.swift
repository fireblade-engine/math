/// A 3x3 matrix.
/// Matrices are stored in column-major order.
@frozen
public struct Matrix3x3<Storage: Storage3x3Protocol>: RandomAccessCollection, MutableCollection, Sendable where Storage.Value == Storage.Element {
    public typealias Element = Storage.Element
    public typealias Index = Storage.Index
    public typealias Value = Storage.Value
    public typealias Vector = Storage.Column

    @usableFromInline var storage: Storage

    /// The start index of the matrix (0).
    public var startIndex: Index {
        storage.startIndex
    }

    /// The end index of the matrix (9).
    public var endIndex: Index {
        storage.endIndex
    }

    /// Returns the index after the given index.
    public func index(after i: Index) -> Index {
        storage.index(after: i)
    }

    /// Returns the index before the given index.
    public func index(before i: Index) -> Index {
        storage.index(before: i)
    }

    @usableFromInline init(storage: Storage) {
        self.storage = storage
    }

    /// The 3x3 identity matrix.
    @inlinable
    public static var identity: Matrix3x3<Storage> {
        Matrix3x3(diagonal: Vector(repeating: 1))
    }

    /// Creates a new 3x3 identity matrix.
    @inlinable
    public init() {
        self = .identity
    }

    /// Creates a new 3x3 matrix with the specified diagonal values.
    /// - Parameter diagonal: The values to place on the diagonal.
    public init(diagonal: Vector) {
        storage = Storage(diagonal: diagonal)
    }

    /// Creates a new 3x3 matrix from an array of column vectors.
    /// - Parameter columns: An array of 3 column vectors.
    public init(_ columns: [Vector]) {
        precondition(columns.count == 3, "Matrix needs exactly 3 Vector vectors")
        storage = Storage(columns)
    }

    /// Creates a new 3x3 matrix from three column vectors.
    /// - Parameters:
    ///   - column0: The first column vector.
    ///   - column1: The second column vector.
    ///   - column2: The third column vector.
    public init(_ column0: Vector, _ column1: Vector, _ column2: Vector) {
        self.init([column0, column1, column2])
    }

    /// Creates a new 3x3 matrix from an array of values in column-major order.
    /// - Parameter values: An array of 9 values.
    public init(_ values: [Storage.Value]) {
        precondition(values.count == 9, "Matrix needs exactly 9 values")
        self.init([Vector(values[0...2]),
                   Vector(values[3...5]),
                   Vector(values[6...8])])
    }

    /// Accesses the value at the specified flat index in column-major order.
    public subscript(index: Index) -> Element {
        get { storage[index] }
        set { storage[index] = newValue }
    }

    /// Accesses the value at the specified column and row.
    /// - Parameters:
    ///   - column: The column index (0-2).
    ///   - row: The row index (0-2).
    public subscript(column: Int, row: Int) -> Value {
        get { storage[column, row] }
        set { storage[column, row] = newValue }
    }

    /// Replaces the specified subrange of elements with the given collection.
    public mutating func replaceSubrange<C: Collection>(_ subrange: Range<Int>, with newElements: C) where Value == C.Element {
        storage.replaceSubrange(subrange, with: newElements)
    }

    /// The column vectors of the matrix.
    @inlinable public var columns: (Vector, Vector, Vector) {
        storage.columns
    }

    /// An array containing the elements of the matrix in column-major order.
    @inlinable public var elements: [Value] {
        [Value](AnyIterator(storage.makeIterator()))
    }

    /// Provides access to the underlying memory as a contiguous buffer.
    @inlinable public func withForcedContiguousStorage<R>(_ body: (UnsafeBufferPointer<Element>) -> R) throws -> R? {
        // https://forums.swift.org/t/se-0256-introduce-mutable-contiguouscollection-protocol/22569/7
        if let result = withContiguousStorageIfAvailable(body) {
            return result
        }

        return ContiguousArray(self).withContiguousStorageIfAvailable(body)
    }

    /// Provides mutable access to the underlying memory as a contiguous buffer.
    @inlinable public mutating func withForcedContiguousMutableStorage<R>(_ body: (inout UnsafeMutableBufferPointer<Element>) -> R) throws -> R? {
        // https://forums.swift.org/t/se-0256-introduce-mutable-contiguouscollection-protocol/22569/7
        if let result = withContiguousMutableStorageIfAvailable(body) {
            return result
        }

        var array = ContiguousArray(self)
        let result = array.withContiguousMutableStorageIfAvailable(body)
        for (idx, arrayIdx) in zip(indices, array.indices) {
            self[idx] = array[arrayIdx]
        }
        return result
    }
}

extension Matrix3x3: ExpressibleByArrayLiteral {
    /// Creates a 3x3 matrix from an array literal in column-major order.
    public init(arrayLiteral elements: Value...) {
        self.init(elements)
    }
}

extension Matrix3x3: Equatable {
    /// Returns a Boolean value indicating whether two matrices are equal.
    public static func == (lhs: Matrix3x3<Storage>, rhs: Matrix3x3<Storage>) -> Bool {
        lhs.storage == rhs.storage
    }
}
