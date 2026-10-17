#if FRB_MATH_USE_SIMD
import func simd.simd_determinant
#endif

/// Computes the determinant of a 4x4 matrix.
/// - Parameter mat: The matrix.
/// - Returns: The determinant.
@inlinable
public func determinant(_ mat: Mat4x4f) -> Float {
    #if FRB_MATH_USE_SIMD
    return simd.simd_determinant(mat.storage)
    #else
    return adjugateAndDeterminant(mat).determinant
    #endif
}

/// Computes the determinant of a 3x3 matrix.
/// - Parameter mat: The matrix.
/// - Returns: The determinant.
@inlinable
public func determinant(_ mat: Mat3x3f) -> Float {
    #if FRB_MATH_USE_SIMD
    return simd.simd_determinant(mat.storage)
    #else
    let termA = mat[0, 0] * (mat[1, 1] * mat[2, 2] - mat[1, 2] * mat[2, 1])
    let termB = mat[0, 1] * (mat[1, 0] * mat[2, 2] - mat[1, 2] * mat[2, 0])
    let termC = mat[0, 2] * (mat[1, 0] * mat[2, 1] - mat[1, 1] * mat[2, 0])
    return termA - termB + termC
    #endif
}

/// Computes the determinant of a 4x4 matrix.
/// - Parameter mat: The matrix.
/// - Returns: The determinant.
@inlinable
public func determinant(_ mat: Mat4x4d) -> Double {
    #if FRB_MATH_USE_SIMD
    return simd.simd_determinant(mat.storage)
    #else
    return adjugateAndDeterminant(mat).determinant
    #endif
}

/// Computes the determinant of a 3x3 matrix.
/// - Parameter mat: The matrix.
/// - Returns: The determinant.
@inlinable
public func determinant(_ mat: Mat3x3d) -> Double {
    #if FRB_MATH_USE_SIMD
    return simd.simd_determinant(mat.storage)
    #else
    let termA = mat[0, 0] * (mat[1, 1] * mat[2, 2] - mat[1, 2] * mat[2, 1])
    let termB = mat[0, 1] * (mat[1, 0] * mat[2, 2] - mat[1, 2] * mat[2, 0])
    let termC = mat[0, 2] * (mat[1, 0] * mat[2, 1] - mat[1, 1] * mat[2, 0])
    return termA - termB + termC
    #endif
}
