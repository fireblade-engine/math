/// Conformance to the Sequence protocol.
extension SIMD4: @retroactive Sequence {}

extension SIMD4 {
    /// A 3D vector containing the x, y, and z components of the 4D vector.
    @inlinable public var xyz: SIMD3<Scalar> {
        SIMD3<Scalar>(x, y, z)
    }
}

extension SIMD4 where Scalar: FloatingPoint {
    /// A Boolean value indicating whether any of the vector's components are NaN.
    @inlinable public var isNaN: Bool {
        x.isNaN || y.isNaN || z.isNaN || w.isNaN
    }
}

extension SIMD4 where Scalar == Double {
    /// The Euclidean length of the vector.
    /// - Complexity: O(1)
    @inlinable public var length: Scalar {
        FirebladeMath.length(self)
    }

    /// A normalized copy of the vector.
    /// - Returns: A vector with the same direction but a length of 1.0.
    /// - Complexity: O(1)
    @inlinable public var normalized: SIMD4<Scalar> {
        FirebladeMath.normalize(self)
    }
}

extension SIMD4 where Scalar == Float {
    /// The Euclidean length of the vector.
    /// - Complexity: O(1)
    @inlinable public var length: Scalar {
        FirebladeMath.length(self)
    }

    /// A normalized copy of the vector.
    /// - Returns: A vector with the same direction but a length of 1.0.
    /// - Complexity: O(1)
    @inlinable public var normalized: SIMD4<Scalar> {
        FirebladeMath.normalize(self)
    }
}
