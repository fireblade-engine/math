/// Extension to add iteration support to SIMD vectors.
extension SIMD {
    /// Creates an iterator that accesses the scalar components of the vector.
    /// - Returns: An iterator over the scalar components.
    @inlinable
    @inline(__always)
    public func makeIterator() -> SIMDScalarIterator<Self> {
        SIMDScalarIterator(self)
    }

    /// An array containing the scalar components of the vector.
    @inlinable public var elements: [Scalar] {
        Array(AnyIterator(makeIterator()))
    }
}

/// An iterator over the scalar components of a SIMD vector.
@frozen
public struct SIMDScalarIterator<Vector: SIMD>: IteratorProtocol {
    @usableFromInline var index: Int
    @usableFromInline let endIndex: Int
    @usableFromInline let vector: Vector

    @inlinable
    init(_ vector: Vector) {
        index = vector.indices.startIndex
        endIndex = vector.indices.endIndex
        self.vector = vector
    }

    /// Returns the next scalar component in the vector.
    /// - Returns: The next scalar component, or `nil` if no more components are available.
    @inlinable
    @inline(__always)
    public mutating func next() -> Vector.Scalar? {
        guard index < endIndex else {
            return nil
        }
        defer { index = vector.indices.index(after: index) }
        return vector[index]
    }
}
