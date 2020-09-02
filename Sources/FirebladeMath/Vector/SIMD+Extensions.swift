//
//  Vector4.swift
//
//
//  Created by Christian Treffs on 23.08.19.
//

extension SIMD {
    public func makeIterator() -> SIMDScalarIterator<Self> {
        SIMDScalarIterator(self)
    }

    public var elements: [Scalar] {
        Array(AnyIterator(makeIterator()))
    }
}

public struct SIMDScalarIterator<Vector>: IteratorProtocol where Vector: SIMD {
    private var index: Int
    private let endIndex: Int
    private let vector: Vector

    init(_ vector: Vector) {
        self.index = vector.indices.startIndex
        self.endIndex = vector.indices.endIndex
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
