extension SIMD {
    public func makeIterator() -> SIMDScalarIterator<Self> {
        SIMDScalarIterator(self)
    }

    public var elements: [Scalar] {
        Array(AnyIterator(makeIterator()))
    }
}

public struct SIMDScalarIterator<Vector: SIMD>: IteratorProtocol {
    private var index: Int
    private let endIndex: Int
    private let vector: Vector

    init(_ vector: Vector) {
        index = vector.indices.startIndex
        endIndex = vector.indices.endIndex
        self.vector = vector
    }

    public mutating func next() -> Vector.Scalar? {
        guard index < endIndex else {
            return nil
        }
        defer { index = vector.indices.index(after: index) }
        return vector[index]
    }
}
