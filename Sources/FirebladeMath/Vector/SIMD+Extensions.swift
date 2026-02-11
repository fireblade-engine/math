/// Extension to add iteration support to SIMD vectors.
extension SIMD {
    /// Creates an iterator that accesses the scalar components of the vector.
    /// - Returns: An iterator over the scalar components.
    public func makeIterator() -> SIMDScalarIterator<Self> {
        SIMDScalarIterator(self)
    }

    /// An array containing the scalar components of the vector.
    public var elements: [Scalar] {
        Array(AnyIterator(makeIterator()))
    }
}

/// An iterator over the scalar components of a SIMD vector.
public struct SIMDScalarIterator<Vector: SIMD>: IteratorProtocol {
    private var index: Int
    private let endIndex: Int
    private let vector: Vector

    init(_ vector: Vector) {
        index = vector.indices.startIndex
        endIndex = vector.indices.endIndex
        self.vector = vector
    }

    /// Returns the next scalar component in the vector.
    /// - Returns: The next scalar component, or `nil` if no more components are available.
    public mutating func next() -> Vector.Scalar? {
        guard index < endIndex else {
            return nil
        }
        defer { index = vector.indices.index(after: index) }
        return vector[index]
    }
}
