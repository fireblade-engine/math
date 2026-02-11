/// Conformance to the Sequence protocol.
extension SIMD3: @retroactive Sequence {}

extension SIMD3 where Scalar: FloatingPoint {
    /// A Boolean value indicating whether any of the vector's components are NaN.
    @inlinable public var isNaN: Bool {
        x.isNaN || y.isNaN || z.isNaN
    }
}

extension SIMD3 where Scalar == Double {
    /// The Euclidean length of the vector.
    /// - Complexity: O(1)
    @inlinable public var length: Scalar {
        FirebladeMath.length(self)
    }

    /// A normalized copy of the vector.
    /// - Returns: A vector with the same direction but a length of 1.0.
    /// - Complexity: O(1)
    @inlinable public var normalized: SIMD3<Scalar> {
        FirebladeMath.normalize(self)
    }

    /// Normalizes the vector.
    /// - Returns: A vector with the same direction but a length of 1.0.
    /// - Complexity: O(1)
    @inlinable
    public func normalize() -> SIMD3<Scalar> {
        FirebladeMath.normalize(self)
    }

    /// Computes the cross product of two 3D vectors.
    /// - Parameter other: The second vector.
    /// - Returns: The cross product of the two vectors.
    /// - Complexity: O(1)
    @inlinable
    public func cross(_ other: SIMD3<Scalar>) -> SIMD3<Scalar> {
        FirebladeMath.cross(self, other)
    }

    /// Computes the dot product of two 3D vectors.
    /// - Parameter other: The second vector.
    /// - Returns: The dot product of the two vectors.
    /// - Complexity: O(1)
    @inlinable
    public func dot(_ other: SIMD3<Scalar>) -> Scalar {
        FirebladeMath.dot(self, other)
    }
}

extension SIMD3 where Scalar == Float {
    /// The Euclidean length of the vector.
    /// - Complexity: O(1)
    @inlinable public var length: Scalar {
        FirebladeMath.length(self)
    }

    /// A normalized copy of the vector.
    /// - Returns: A vector with the same direction but a length of 1.0.
    /// - Complexity: O(1)
    @inlinable public var normalized: SIMD3<Scalar> {
        FirebladeMath.normalize(self)
    }

    /// Normalizes the vector.
    /// - Returns: A vector with the same direction but a length of 1.0.
    /// - Complexity: O(1)
    @inlinable
    public func normalize() -> SIMD3<Scalar> {
        FirebladeMath.normalize(self)
    }

    /// Computes the cross product of two 3D vectors.
    /// - Parameter other: The second vector.
    /// - Returns: The cross product of the two vectors.
    /// - Complexity: O(1)
    @inlinable
    public func cross(_ other: SIMD3<Scalar>) -> SIMD3<Scalar> {
        FirebladeMath.cross(self, other)
    }

    /// Computes the dot product of two 3D vectors.
    /// - Parameter other: The second vector.
    /// - Returns: The dot product of the two vectors.
    /// - Complexity: O(1)
    @inlinable
    public func dot(_ other: SIMD3<Scalar>) -> Scalar {
        FirebladeMath.dot(self, other)
    }
}
