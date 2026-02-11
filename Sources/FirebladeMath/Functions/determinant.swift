#if FRB_MATH_USE_SIMD
import func simd.simd_determinant
#endif

/// Computes the determinant of a 4x4 matrix.
/// - Parameter mat: The matrix.
/// - Returns: The determinant.
public func determinant(_ mat: Mat4x4f) -> Float {
    #if FRB_MATH_USE_SIMD
    return simd.simd_determinant(mat.storage)
    #else
    let subFactor00 = mat[1, 1] * (mat[2, 2] * mat[3, 3] - mat[2, 3] * mat[3, 2])
    let subFactor01 = mat[1, 2] * (mat[2, 1] * mat[3, 3] - mat[2, 3] * mat[3, 1])
    let subFactor02 = mat[1, 3] * (mat[2, 1] * mat[3, 2] - mat[2, 2] * mat[3, 1])
    let det0 = mat[0, 0] * (subFactor00 - subFactor01 + subFactor02)

    let subFactor10 = mat[1, 0] * (mat[2, 2] * mat[3, 3] - mat[2, 3] * mat[3, 2])
    let subFactor11 = mat[1, 2] * (mat[2, 0] * mat[3, 3] - mat[2, 3] * mat[3, 0])
    let subFactor12 = mat[1, 3] * (mat[2, 0] * mat[3, 2] - mat[2, 2] * mat[3, 0])
    let det1 = mat[0, 1] * (subFactor10 - subFactor11 + subFactor12)

    let subFactor20 = mat[1, 0] * (mat[2, 1] * mat[3, 3] - mat[2, 3] * mat[3, 1])
    let subFactor21 = mat[1, 1] * (mat[2, 0] * mat[3, 3] - mat[2, 3] * mat[3, 0])
    let subFactor22 = mat[1, 3] * (mat[2, 0] * mat[3, 1] - mat[2, 1] * mat[3, 0])
    let det2 = mat[0, 2] * (subFactor20 - subFactor21 + subFactor22)

    let subFactor30 = mat[1, 0] * (mat[2, 1] * mat[3, 2] - mat[2, 2] * mat[3, 1])
    let subFactor31 = mat[1, 1] * (mat[2, 0] * mat[3, 2] - mat[2, 2] * mat[3, 0])
    let subFactor32 = mat[1, 2] * (mat[2, 0] * mat[3, 1] - mat[2, 1] * mat[3, 0])
    let det3 = mat[0, 3] * (subFactor30 - subFactor31 + subFactor32)

    return det0 - det1 + det2 - det3
    #endif
}

/// Computes the determinant of a 3x3 matrix.
/// - Parameter mat: The matrix.
/// - Returns: The determinant.
public func determinant(_ mat: Mat3x3f) -> Float {
    #if FRB_MATH_USE_SIMD
    return simd.simd_determinant(mat.storage)
    #else
    let a = mat[0, 0] * (mat[1, 1] * mat[2, 2] - mat[1, 2] * mat[2, 1])
    let b = mat[0, 1] * (mat[1, 0] * mat[2, 2] - mat[1, 2] * mat[2, 0])
    let c = mat[0, 2] * (mat[1, 0] * mat[2, 1] - mat[1, 1] * mat[2, 0])
    return a - b + c
    #endif
}

/// Computes the determinant of a 4x4 matrix.
/// - Parameter mat: The matrix.
/// - Returns: The determinant.
public func determinant(_ mat: Mat4x4d) -> Double {
    #if FRB_MATH_USE_SIMD
    return simd.simd_determinant(mat.storage)
    #else
    let subFactor00 = mat[1, 1] * (mat[2, 2] * mat[3, 3] - mat[2, 3] * mat[3, 2])
    let subFactor01 = mat[1, 2] * (mat[2, 1] * mat[3, 3] - mat[2, 3] * mat[3, 1])
    let subFactor02 = mat[1, 3] * (mat[2, 1] * mat[3, 2] - mat[2, 2] * mat[3, 1])
    let det0 = mat[0, 0] * (subFactor00 - subFactor01 + subFactor02)

    let subFactor10 = mat[1, 0] * (mat[2, 2] * mat[3, 3] - mat[2, 3] * mat[3, 2])
    let subFactor11 = mat[1, 2] * (mat[2, 0] * mat[3, 3] - mat[2, 3] * mat[3, 0])
    let subFactor12 = mat[1, 3] * (mat[2, 0] * mat[3, 2] - mat[2, 2] * mat[3, 0])
    let det1 = mat[0, 1] * (subFactor10 - subFactor11 + subFactor12)

    let subFactor20 = mat[1, 0] * (mat[2, 1] * mat[3, 3] - mat[2, 3] * mat[3, 1])
    let subFactor21 = mat[1, 1] * (mat[2, 0] * mat[3, 3] - mat[2, 3] * mat[3, 0])
    let subFactor22 = mat[1, 3] * (mat[2, 0] * mat[3, 1] - mat[2, 1] * mat[3, 0])
    let det2 = mat[0, 2] * (subFactor20 - subFactor21 + subFactor22)

    let subFactor30 = mat[1, 0] * (mat[2, 1] * mat[3, 2] - mat[2, 2] * mat[3, 1])
    let subFactor31 = mat[1, 1] * (mat[2, 0] * mat[3, 2] - mat[2, 2] * mat[3, 0])
    let subFactor32 = mat[1, 2] * (mat[2, 0] * mat[3, 1] - mat[2, 1] * mat[3, 0])
    let det3 = mat[0, 3] * (subFactor30 - subFactor31 + subFactor32)

    return det0 - det1 + det2 - det3
    #endif
}

/// Computes the determinant of a 3x3 matrix.
/// - Parameter mat: The matrix.
/// - Returns: The determinant.
public func determinant(_ mat: Mat3x3d) -> Double {
    #if FRB_MATH_USE_SIMD
    return simd.simd_determinant(mat.storage)
    #else
    let a = mat[0, 0] * (mat[1, 1] * mat[2, 2] - mat[1, 2] * mat[2, 1])
    let b = mat[0, 1] * (mat[1, 0] * mat[2, 2] - mat[1, 2] * mat[2, 0])
    let c = mat[0, 2] * (mat[1, 0] * mat[2, 1] - mat[1, 1] * mat[2, 0])
    return a - b + c
    #endif
}
