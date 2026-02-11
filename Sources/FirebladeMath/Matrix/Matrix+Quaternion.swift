extension Mat4x4f {
    /// Creates a new matrix from the specified quaternion.
    /// Quaternion will be normalized.
    /// - Parameter quaternion: The orientation quaternion.
    public init(orientation quaternion: Quat4f) {
        self = matrix4x4(from: quaternion.normalized)
    }

    /// The rotation represented by the matrix as a quaternion.
    ///
    /// The last row and column of the matrix are ignored. This
    /// function is equivalent to calling `simd_quaternion` with the upper-left 3x3
    /// sub-matrix.
    @inlinable public var quaternion: Quat4f {
        FirebladeMath.quaternion(matrix: self)
    }
}
