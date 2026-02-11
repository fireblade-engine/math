extension SIMD2: @retroactive Sequence {}

extension SIMD2 where Scalar: FloatingPoint {
    /// A Boolean value indicating whether any of the vector's components are NaN.
    @inlinable public var isNaN: Bool {
        x.isNaN || y.isNaN
    }
}

extension SIMD2 where Scalar == Double {
    /// The Euclidean length of the vector.
    /// - Complexity: O(1)
    @inlinable public var length: Scalar {
        FirebladeMath.length(self)
    }

    /// A normalized copy of the vector.
    /// - Returns: A vector with the same direction but a length of 1.0.
    /// - Complexity: O(1)
    @inlinable public var normalized: SIMD2<Scalar> {
        normalize(self)
    }
}

extension SIMD2 where Scalar == Float {
    /// The Euclidean length of the vector.
    /// - Complexity: O(1)
    @inlinable public var length: Scalar {
        FirebladeMath.length(self)
    }

    /// A normalized copy of the vector.
    /// - Returns: A vector with the same direction but a length of 1.0.
    /// - Complexity: O(1)
    @inlinable public var normalized: SIMD2<Scalar> {
        normalize(self)
    }
}