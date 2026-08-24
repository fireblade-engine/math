// MARK: - 4x4f

extension Mat4x4f {
    /// Multiplies two 4x4 float matrices.
    /// - Parameters:
    ///   - lhs: The left-hand side matrix.
    ///   - rhs: The right-hand side matrix.
    /// - Returns: The product of the two matrices.
    @inlinable
    public static func * (lhs: Mat4x4f, rhs: Mat4x4f) -> Mat4x4f {
        FirebladeMath.multiply(lhs, rhs)
    }

    /// Multiplies a 4x4 float matrix by a scalar.
    /// - Parameters:
    ///   - lhs: The scalar value.
    ///   - rhs: The matrix.
    /// - Returns: The resulting matrix.
    @inlinable
    public static func * (lhs: Float, rhs: Mat4x4f) -> Mat4x4f {
        FirebladeMath.multiply(lhs, rhs)
    }

    /// Multiplies a 4D float vector by a 4x4 float matrix.
    /// - Parameters:
    ///   - lhs: The vector.
    ///   - rhs: The matrix.
    /// - Returns: The resulting vector.
    @inlinable
    public static func * (lhs: Vec4f, rhs: Mat4x4f) -> Vec4f {
        FirebladeMath.multiply(lhs, rhs)
    }

    /// Multiplies a 4x4 float matrix by a 4D float vector.
    /// - Parameters:
    ///   - lhs: The matrix.
    ///   - rhs: The vector.
    /// - Returns: The resulting vector.
    @inlinable
    public static func * (lhs: Mat4x4f, rhs: Vec4f) -> Vec4f {
        FirebladeMath.multiply(lhs, rhs)
    }

    /// Multiplies two 4x4 float matrices and assigns the result to the first matrix.
    /// - Parameters:
    ///   - lhs: The left-hand side matrix to be updated.
    ///   - rhs: The right-hand side matrix.
    @inlinable
    public static func *= (lhs: inout Mat4x4f, rhs: Mat4x4f) {
        lhs = FirebladeMath.multiply(lhs, rhs)
    }
}

// MARK: - 4x4d

extension Mat4x4d {
    /// Multiplies two 4x4 double matrices.
    /// - Parameters:
    ///   - lhs: The left-hand side matrix.
    ///   - rhs: The right-hand side matrix.
    /// - Returns: The product of the two matrices.
    @inlinable
    public static func * (lhs: Mat4x4d, rhs: Mat4x4d) -> Mat4x4d {
        FirebladeMath.multiply(lhs, rhs)
    }

    /// Multiplies a 4x4 double matrix by a scalar.
    /// - Parameters:
    ///   - lhs: The scalar value.
    ///   - rhs: The matrix.
    /// - Returns: The resulting matrix.
    @inlinable
    public static func * (lhs: Double, rhs: Mat4x4d) -> Mat4x4d {
        FirebladeMath.multiply(lhs, rhs)
    }

    /// Multiplies a 4D double vector by a 4x4 double matrix.
    /// - Parameters:
    ///   - lhs: The vector.
    ///   - rhs: The matrix.
    /// - Returns: The resulting vector.
    @inlinable
    public static func * (lhs: Vec4d, rhs: Mat4x4d) -> Vec4d {
        FirebladeMath.multiply(lhs, rhs)
    }

    /// Multiplies a 4x4 double matrix by a 4D double vector.
    /// - Parameters:
    ///   - lhs: The matrix.
    ///   - rhs: The vector.
    /// - Returns: The resulting vector.
    @inlinable
    public static func * (lhs: Mat4x4d, rhs: Vec4d) -> Vec4d {
        FirebladeMath.multiply(lhs, rhs)
    }

    /// Multiplies two 4x4 double matrices and assigns the result to the first matrix.
    /// - Parameters:
    ///   - lhs: The left-hand side matrix to be updated.
    ///   - rhs: The right-hand side matrix.
    @inlinable
    public static func *= (lhs: inout Mat4x4d, rhs: Mat4x4d) {
        lhs = FirebladeMath.multiply(lhs, rhs)
    }
}

// MARK: - 3x3f

extension Mat3x3f {
    /// Multiplies two 3x3 float matrices.
    /// - Parameters:
    ///   - lhs: The left-hand side matrix.
    ///   - rhs: The right-hand side matrix.
    /// - Returns: The product of the two matrices.
    @inlinable
    public static func * (lhs: Mat3x3f, rhs: Mat3x3f) -> Mat3x3f {
        FirebladeMath.multiply(lhs, rhs)
    }

    /// Multiplies a 3x3 float matrix by a scalar.
    /// - Parameters:
    ///   - lhs: The scalar value.
    ///   - rhs: The matrix.
    /// - Returns: The resulting matrix.
    @inlinable
    public static func * (lhs: Float, rhs: Mat3x3f) -> Mat3x3f {
        FirebladeMath.multiply(lhs, rhs)
    }

    /// Multiplies a 3D float vector by a 3x3 float matrix.
    /// - Parameters:
    ///   - lhs: The vector.
    ///   - rhs: The matrix.
    /// - Returns: The resulting vector.
    @inlinable
    public static func * (lhs: Vec3f, rhs: Mat3x3f) -> Vec3f {
        FirebladeMath.multiply(lhs, rhs)
    }

    /// Multiplies a 3x3 float matrix by a 3D float vector.
    /// - Parameters:
    ///   - lhs: The matrix.
    ///   - rhs: The vector.
    /// - Returns: The resulting vector.
    @inlinable
    public static func * (lhs: Mat3x3f, rhs: Vec3f) -> Vec3f {
        FirebladeMath.multiply(lhs, rhs)
    }

    /// Multiplies two 3x3 float matrices and assigns the result to the first matrix.
    /// - Parameters:
    ///   - lhs: The left-hand side matrix to be updated.
    ///   - rhs: The right-hand side matrix.
    @inlinable
    public static func *= (lhs: inout Mat3x3f, rhs: Mat3x3f) {
        lhs = FirebladeMath.multiply(lhs, rhs)
    }
}

// MARK: - 3x3d

extension Mat3x3d {
    /// Multiplies two 3x3 double matrices.
    /// - Parameters:
    ///   - lhs: The left-hand side matrix.
    ///   - rhs: The right-hand side matrix.
    /// - Returns: The product of the two matrices.
    @inlinable
    public static func * (lhs: Mat3x3d, rhs: Mat3x3d) -> Mat3x3d {
        FirebladeMath.multiply(lhs, rhs)
    }

    /// Multiplies a 3x3 double matrix by a scalar.
    /// - Parameters:
    ///   - lhs: The scalar value.
    ///   - rhs: The matrix.
    /// - Returns: The resulting matrix.
    @inlinable
    public static func * (lhs: Double, rhs: Mat3x3d) -> Mat3x3d {
        FirebladeMath.multiply(lhs, rhs)
    }

    /// Multiplies a 3D double vector by a 3x3 double matrix.
    /// - Parameters:
    ///   - lhs: The vector.
    ///   - rhs: The matrix.
    /// - Returns: The resulting vector.
    @inlinable
    public static func * (lhs: Vec3d, rhs: Mat3x3d) -> Vec3d {
        FirebladeMath.multiply(lhs, rhs)
    }

    /// Multiplies a 3x3 double matrix by a 3D double vector.
    /// - Parameters:
    ///   - lhs: The matrix.
    ///   - rhs: The vector.
    /// - Returns: The resulting vector.
    @inlinable
    public static func * (lhs: Mat3x3d, rhs: Vec3d) -> Vec3d {
        FirebladeMath.multiply(lhs, rhs)
    }

    /// Multiplies two 3x3 double matrices and assigns the result to the first matrix.
    /// - Parameters:
    ///   - lhs: The left-hand side matrix to be updated.
    ///   - rhs: The right-hand side matrix.
    @inlinable
    public static func *= (lhs: inout Mat3x3d, rhs: Mat3x3d) {
        lhs = FirebladeMath.multiply(lhs, rhs)
    }
}

// MARK: - 2x2f

extension Mat2x2f {
    /// Multiplies two 2x2 float matrices.
    /// - Parameters:
    ///   - lhs: The left-hand side matrix.
    ///   - rhs: The right-hand side matrix.
    /// - Returns: The product of the two matrices.
    @inlinable
    public static func * (lhs: Mat2x2f, rhs: Mat2x2f) -> Mat2x2f {
        FirebladeMath.multiply(lhs, rhs)
    }

    /// Multiplies a 2x2 float matrix by a scalar.
    /// - Parameters:
    ///   - lhs: The scalar value.
    ///   - rhs: The matrix.
    /// - Returns: The resulting matrix.
    @inlinable
    public static func * (lhs: Float, rhs: Mat2x2f) -> Mat2x2f {
        FirebladeMath.multiply(lhs, rhs)
    }

    /// Multiplies a 2D float vector by a 2x2 float matrix.
    /// - Parameters:
    ///   - lhs: The vector.
    ///   - rhs: The matrix.
    /// - Returns: The resulting vector.
    @inlinable
    public static func * (lhs: Vec2f, rhs: Mat2x2f) -> Vec2f {
        FirebladeMath.multiply(lhs, rhs)
    }

    /// Multiplies a 2x2 float matrix by a 2D float vector.
    /// - Parameters:
    ///   - lhs: The matrix.
    ///   - rhs: The vector.
    /// - Returns: The resulting vector.
    @inlinable
    public static func * (lhs: Mat2x2f, rhs: Vec2f) -> Vec2f {
        FirebladeMath.multiply(lhs, rhs)
    }

    /// Multiplies two 2x2 float matrices and assigns the result to the first matrix.
    /// - Parameters:
    ///   - lhs: The left-hand side matrix to be updated.
    ///   - rhs: The right-hand side matrix.
    @inlinable
    public static func *= (lhs: inout Mat2x2f, rhs: Mat2x2f) {
        lhs = FirebladeMath.multiply(lhs, rhs)
    }
}

// MARK: - 2x2d

extension Mat2x2d {
    /// Multiplies two 2x2 double matrices.
    /// - Parameters:
    ///   - lhs: The left-hand side matrix.
    ///   - rhs: The right-hand side matrix.
    /// - Returns: The product of the two matrices.
    @inlinable
    public static func * (lhs: Mat2x2d, rhs: Mat2x2d) -> Mat2x2d {
        FirebladeMath.multiply(lhs, rhs)
    }

    /// Multiplies a 2x2 double matrix by a scalar.
    /// - Parameters:
    ///   - lhs: The scalar value.
    ///   - rhs: The matrix.
    /// - Returns: The resulting matrix.
    @inlinable
    public static func * (lhs: Double, rhs: Mat2x2d) -> Mat2x2d {
        FirebladeMath.multiply(lhs, rhs)
    }

    /// Multiplies a 2D double vector by a 2x2 double matrix.
    /// - Parameters:
    ///   - lhs: The vector.
    ///   - rhs: The matrix.
    /// - Returns: The resulting vector.
    @inlinable
    public static func * (lhs: Vec2d, rhs: Mat2x2d) -> Vec2d {
        FirebladeMath.multiply(lhs, rhs)
    }

    /// Multiplies a 2x2 double matrix by a 2D double vector.
    /// - Parameters:
    ///   - lhs: The matrix.
    ///   - rhs: The vector.
    /// - Returns: The resulting vector.
    @inlinable
    public static func * (lhs: Mat2x2d, rhs: Vec2d) -> Vec2d {
        FirebladeMath.multiply(lhs, rhs)
    }

    /// Multiplies two 2x2 double matrices and assigns the result to the first matrix.
    /// - Parameters:
    ///   - lhs: The left-hand side matrix to be updated.
    ///   - rhs: The right-hand side matrix.
    @inlinable
    public static func *= (lhs: inout Mat2x2d, rhs: Mat2x2d) {
        lhs = FirebladeMath.multiply(lhs, rhs)
    }
}
