#if FRB_MATH_USE_SIMD
import func simd.simd_inverse
#endif

/// Computes the inverse of a 3x3 matrix.
/// - Parameter matrix: The matrix to invert.
/// - Returns: The inverse matrix.
public func inverse(_ matrix: Mat3x3f) -> Mat3x3f {
    #if FRB_MATH_USE_SIMD
    return Mat3x3f(storage: simd.simd_inverse(matrix.storage))
    #else
    let adj: Mat3x3f = adjugate(matrix)
    let det: Float = determinant(matrix)
    return multiply(1.0 / det, adj)
    #endif
}

/// Computes the inverse of a 3x3 matrix.
/// - Parameter matrix: The matrix to invert.
/// - Returns: The inverse matrix.
public func inverse(_ matrix: Mat3x3d) -> Mat3x3d {
    #if FRB_MATH_USE_SIMD
    return Mat3x3d(storage: simd.simd_inverse(matrix.storage))
    #else
    let adj: Mat3x3d = adjugate(matrix)
    let det: Double = determinant(matrix)
    return multiply(1.0 / det, adj)
    #endif
}

/// Computes the inverse of a 4x4 matrix.
/// - Parameter matrix: The matrix to invert.
/// - Returns: The inverse matrix.
public func inverse(_ matrix: Mat4x4f) -> Mat4x4f {
    #if FRB_MATH_USE_SIMD
    return Mat4x4f(storage: simd.simd_inverse(matrix.storage))
    #else
    let adj: Mat4x4f = adjugate(matrix)
    let det: Float = determinant(matrix)
    return multiply(1.0 / det, adj)
    #endif
}

/// Computes the inverse of a 4x4 matrix.
/// - Parameter matrix: The matrix to invert.
/// - Returns: The inverse matrix.
public func inverse(_ matrix: Mat4x4d) -> Mat4x4d {
    #if FRB_MATH_USE_SIMD
    return Mat4x4d(storage: simd.simd_inverse(matrix.storage))
    #else
    let adj: Mat4x4d = adjugate(matrix)
    let det: Double = determinant(matrix)
    return multiply(1.0 / det, adj)
    #endif
}

/// Computes the inverse of a quaternion.
/// - Parameter quat: The quaternion.
/// - Returns: The inverse quaternion.
public func inverse(_ quat: Quat4f) -> Quat4f {
    #if FRB_MATH_USE_SIMD
    return Quat4f(storage: simd_inverse(quat.storage))
    #else
    return conjugate(quat) * (1.0 / (length(quat) * length(quat)))
    #endif
}

/// Computes the inverse of a quaternion.
/// - Parameter quat: The quaternion.
/// - Returns: The inverse quaternion.
public func inverse(_ quat: Quat4d) -> Quat4d {
    #if FRB_MATH_USE_SIMD
    return Quat4d(storage: simd_inverse(quat.storage))
    #else
    return conjugate(quat) * (1.0 / (length(quat) * length(quat)))
    #endif
}
