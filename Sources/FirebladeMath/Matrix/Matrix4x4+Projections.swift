#if FRB_MATH_USE_SIMD
import func simd.simd_matrix4x4
#endif

// MARK: - Float

extension Mat4x4f {
    /// Perspective projection matrix in right-handed coordinates.
    /// - Parameters:
    ///   - fovyRad: The field of view in radians.
    ///   - aspect: The aspect ratio.
    ///   - zNear: The distance to the near clipping plane.
    ///   - zFar: The distance to the far clipping plane.
    /// - Returns: The perspective projection matrix.
    public static func perspectiveRH(fovy fovyRad: Float, aspect: Float, zNear: Float, zFar: Float) -> Self {
        let yScale: Float = 1.0 / tan(fovyRad / 2.0)
        let xScale: Float = yScale / aspect

        let m00: Float = xScale
        let m11: Float = yScale
        let m22: Float = zFar / (zNear - zFar)
        let m23: Float = -1.0
        let m32: Float = (zNear * zFar) / (zNear - zFar)
        let m33: Float = 0.0

        let P = Vector(m00, 0.0, 0.0, 0.0)
        let Q = Vector(0.0, m11, 0.0, 0.0)
        let R = Vector(0.0, 0.0, m22, m23)
        let S = Vector(0.0, 0.0, m32, m33)

        return Self(P, Q, R, S)
    }

    /// Perspective projection matrix in left-handed coordinates.
    /// - Parameters:
    ///   - fovyRad: The field of view in radians.
    ///   - aspect: The aspect ratio.
    ///   - zNear: The distance to the near clipping plane.
    ///   - zFar: The distance to the far clipping plane.
    /// - Returns: The perspective projection matrix.
    public static func perspectiveLH(fovy fovyRad: Float, aspect: Float, zNear: Float, zFar: Float) -> Self {
        let yScale: Float = 1.0 / tan(fovyRad / 2.0)
        let xScale: Float = yScale / aspect

        let m00: Float = xScale
        let m11: Float = yScale
        let m22: Float = zFar / (zFar - zNear)
        let m23: Float = 1.0
        let m32: Float = -(zNear * zFar) / (zFar - zNear)
        let m33: Float = 0.0

        let P = Vector(m00, 0.0, 0.0, 0.0)
        let Q = Vector(0.0, m11, 0.0, 0.0)
        let R = Vector(0.0, 0.0, m22, m23)
        let S = Vector(0.0, 0.0, m32, m33)

        return Self(P, Q, R, S)
    }

    /// Orthographic projection matrix in right-handed coordinates.
    /// - Parameters:
    ///   - left: The left boundary.
    ///   - right: The right boundary.
    ///   - top: The top boundary.
    ///   - bottom: The bottom boundary.
    ///   - zNear: The distance to the near clipping plane.
    ///   - zFar: The distance to the far clipping plane.
    /// - Returns: The orthographic projection matrix.
    public static func orthographicRH(left: Float, right: Float, top: Float, bottom: Float, zNear: Float, zFar: Float) -> Self {
        let m00: Float = 2.0 / (right - left)
        let m03: Float = (left + right) / (left - right)
        let m11: Float = 2.0 / (top - bottom)
        let m13: Float = (top + bottom) / (bottom - top)
        let m22: Float = 1.0 / (zNear - zFar)
        let m23: Float = zNear / (zNear - zFar)
        let m33: Float = 1.0

        let P = Vector(m00, 0.0, 0.0, 0.0)
        let Q = Vector(0.0, m11, 0.0, 0.0)
        let R = Vector(0.0, 0.0, m22, 0.0)
        let S = Vector(m03, m13, m23, m33)

        return Self(P, Q, R, S)
    }

    /// Orthographic projection matrix in left-handed coordinates.
    /// - Parameters:
    ///   - left: The left boundary.
    ///   - right: The right boundary.
    ///   - top: The top boundary.
    ///   - bottom: The bottom boundary.
    ///   - zNear: The distance to the near clipping plane.
    ///   - zFar: The distance to the far clipping plane.
    /// - Returns: The orthographic projection matrix.
    public static func orthographicLH(left: Float, right: Float, top: Float, bottom: Float, zNear: Float, zFar: Float) -> Self {
        let m00: Float = 2.0 / (right - left)
        let m03: Float = (left + right) / (left - right)
        let m11: Float = 2.0 / (top - bottom)
        let m13: Float = (top + bottom) / (bottom - top)
        let m22: Float = 1.0 / (zFar - zNear)
        let m23: Float = zNear / (zNear - zFar)
        let m33: Float = 1.0

        let P = Vector(m00, 0.0, 0.0, 0.0)
        let Q = Vector(0.0, m11, 0.0, 0.0)
        let R = Vector(0.0, 0.0, m22, 0.0)
        let S = Vector(m03, m13, m23, m33)

        return Self(P, Q, R, S)
    }
}

// MARK: - Double

extension Mat4x4d {
    /// Perspective projection matrix in right-handed coordinates.
    /// - Parameters:
    ///   - fovyRad: The field of view in radians.
    ///   - aspect: The aspect ratio.
    ///   - zNear: The distance to the near clipping plane.
    ///   - zFar: The distance to the far clipping plane.
    /// - Returns: The perspective projection matrix.
    public static func perspectiveRH(fovy fovyRad: Double, aspect: Double, zNear: Double, zFar: Double) -> Self {
        let yScale = 1.0 / tan(fovyRad / 2.0)
        let xScale: Double = yScale / aspect

        let m00: Double = xScale
        let m11: Double = yScale
        let m22: Double = zFar / (zNear - zFar)
        let m23: Double = -1.0
        let m32: Double = (zNear * zFar) / (zNear - zFar)
        let m33 = 0.0

        let P = Vector(m00, 0.0, 0.0, 0.0)
        let Q = Vector(0.0, m11, 0.0, 0.0)
        let R = Vector(0.0, 0.0, m22, m23)
        let S = Vector(0.0, 0.0, m32, m33)

        return Self(P, Q, R, S)
    }

    /// Perspective projection matrix in left-handed coordinates.
    /// - Parameters:
    ///   - fovyRad: The field of view in radians.
    ///   - aspect: The aspect ratio.
    ///   - zNear: The distance to the near clipping plane.
    ///   - zFar: The distance to the far clipping plane.
    /// - Returns: The perspective projection matrix.
    public static func perspectiveLH(fovy fovyRad: Double, aspect: Double, zNear: Double, zFar: Double) -> Self {
        let yScale = 1.0 / tan(fovyRad / 2.0)
        let xScale: Double = yScale / aspect

        let m00: Double = xScale
        let m11: Double = yScale
        let m22: Double = zFar / (zFar - zNear)
        let m23 = 1.0
        let m32: Double = -(zNear * zFar) / (zFar - zNear)
        let m33 = 0.0

        let P = Vector(m00, 0.0, 0.0, 0.0)
        let Q = Vector(0.0, m11, 0.0, 0.0)
        let R = Vector(0.0, 0.0, m22, m23)
        let S = Vector(0.0, 0.0, m32, m33)

        return Self(P, Q, R, S)
    }

    /// Orthographic projection matrix in right-handed coordinates.
    /// - Parameters:
    ///   - left: The left boundary.
    ///   - right: The right boundary.
    ///   - top: The top boundary.
    ///   - bottom: The bottom boundary.
    ///   - zNear: The distance to the near clipping plane.
    ///   - zFar: The distance to the far clipping plane.
    /// - Returns: The orthographic projection matrix.
    public static func orthographicRH(left: Double, right: Double, top: Double, bottom: Double, zNear: Double, zFar: Double) -> Self {
        let m00 = 2.0 / (right - left)
        let m03: Double = (left + right) / (left - right)
        let m11 = 2.0 / (top - bottom)
        let m13: Double = (top + bottom) / (bottom - top)
        let m22 = 1.0 / (zNear - zFar)
        let m23: Double = zNear / (zNear - zFar)
        let m33 = 1.0

        let P = Vector(m00, 0.0, 0.0, 0.0)
        let Q = Vector(0.0, m11, 0.0, 0.0)
        let R = Vector(0.0, 0.0, m22, 0.0)
        let S = Vector(m03, m13, m23, m33)

        return Self(P, Q, R, S)
    }

    /// Orthographic projection matrix in left-handed coordinates.
    /// - Parameters:
    ///   - left: The left boundary.
    ///   - right: The right boundary.
    ///   - top: The top boundary.
    ///   - bottom: The bottom boundary.
    ///   - zNear: The distance to the near clipping plane.
    ///   - zFar: The distance to the far clipping plane.
    /// - Returns: The orthographic projection matrix.
    public static func orthographicLH(left: Double, right: Double, top: Double, bottom: Double, zNear: Double, zFar: Double) -> Self {
        let m00 = 2.0 / (right - left)
        let m03: Double = (left + right) / (left - right)
        let m11 = 2.0 / (top - bottom)
        let m13: Double = (top + bottom) / (bottom - top)
        let m22 = 1.0 / (zFar - zNear)
        let m23: Double = zNear / (zNear - zFar)
        let m33 = 1.0

        let P = Vector(m00, 0.0, 0.0, 0.0)
        let Q = Vector(0.0, m11, 0.0, 0.0)
        let R = Vector(0.0, 0.0, m22, 0.0)
        let S = Vector(m03, m13, m23, m33)

        return Self(P, Q, R, S)
    }
}
