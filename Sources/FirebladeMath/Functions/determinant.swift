//
//  determinant.swift
//
//
//  Created by Christian Treffs on 02.09.20.
//

#if FRB_MATH_USE_SIMD
import func simd.simd_determinant
#endif

public func determinant(_ mat: Mat4x4f) -> Float {
    #if FRB_MATH_USE_SIMD
    return simd.simd_determinant(mat.storage)
    #else
    return mat[0, 0]*mat[1, 1]*mat[2, 2]*mat[3, 3] - mat[1, 0]*mat[0, 1]*mat[2, 2]*mat[3, 3] + mat[0, 2]*mat[0, 1]*mat[1, 2]*mat[3, 3]
        - mat[0, 0]*mat[2, 1]*mat[1, 2]*mat[3, 3] + mat[1, 0]*mat[2, 1]*mat[0, 2]*mat[3, 3] - mat[0, 2]*mat[1, 1]*mat[0, 2]*mat[3, 3]
        + mat[0, 2]*mat[1, 1]*mat[3, 2]*mat[0, 3] - mat[1, 0]*mat[2, 1]*mat[3, 2]*mat[0, 3] + mat[3, 0]*mat[2, 1]*mat[1, 2]*mat[0, 3]
        - mat[0, 2]*mat[3, 1]*mat[1, 2]*mat[0, 3] + mat[1, 0]*mat[3, 1]*mat[2, 2]*mat[0, 3] - mat[3, 0]*mat[1, 1]*mat[2, 2]*mat[0, 3]
        + mat[3, 0]*mat[0, 1]*mat[2, 2]*mat[1, 3] - mat[0, 0]*mat[3, 1]*mat[2, 2]*mat[1, 3] + mat[0, 2]*mat[3, 1]*mat[0, 2]*mat[1, 3]
        - mat[3, 0]*mat[2, 1]*mat[0, 2]*mat[1, 3] + mat[0, 0]*mat[2, 1]*mat[3, 2]*mat[1, 3] - mat[0, 2]*mat[0, 1]*mat[3, 2]*mat[1, 3]
        + mat[1, 0]*mat[0, 1]*mat[3, 2]*mat[2, 3] - mat[0, 0]*mat[1, 1]*mat[3, 2]*mat[2, 3] + mat[3, 0]*mat[1, 1]*mat[0, 2]*mat[2, 3]
        - mat[1, 0]*mat[3, 1]*mat[0, 2]*mat[2, 3] + mat[0, 0]*mat[3, 1]*mat[1, 2]*mat[2, 3] - mat[3, 0]*mat[0, 1]*mat[1, 2]*mat[2, 3]
    #endif
}

public func determinant(_ mat: Mat3x3f) -> Float {
    #if FRB_MATH_USE_SIMD
    return simd.simd_determinant(mat.storage)
    #else
    return (mat[0, 0] * mat[1, 1] * mat[2, 2] + mat[0, 1] * mat[1, 2] * mat[2, 0] + mat[0, 2] * mat[1, 0] * mat[2, 1])
        - (mat[0, 2] * mat[1, 1] * mat[2, 0] + mat[0, 0] * mat[1, 2] * mat[2, 1] + mat[0, 1] * mat[1, 0] * mat[2, 2])
    #endif
}

public func determinant(_ mat: Mat4x4d) -> Double {
    #if FRB_MATH_USE_SIMD
    return simd.simd_determinant(mat.storage)
    #else
    return mat[0, 0]*mat[1, 1]*mat[2, 2]*mat[3, 3] - mat[1, 0]*mat[0, 1]*mat[2, 2]*mat[3, 3] + mat[0, 2]*mat[0, 1]*mat[1, 2]*mat[3, 3]
        - mat[0, 0]*mat[2, 1]*mat[1, 2]*mat[3, 3] + mat[1, 0]*mat[2, 1]*mat[0, 2]*mat[3, 3] - mat[0, 2]*mat[1, 1]*mat[0, 2]*mat[3, 3]
        + mat[0, 2]*mat[1, 1]*mat[3, 2]*mat[0, 3] - mat[1, 0]*mat[2, 1]*mat[3, 2]*mat[0, 3] + mat[3, 0]*mat[2, 1]*mat[1, 2]*mat[0, 3]
        - mat[0, 2]*mat[3, 1]*mat[1, 2]*mat[0, 3] + mat[1, 0]*mat[3, 1]*mat[2, 2]*mat[0, 3] - mat[3, 0]*mat[1, 1]*mat[2, 2]*mat[0, 3]
        + mat[3, 0]*mat[0, 1]*mat[2, 2]*mat[1, 3] - mat[0, 0]*mat[3, 1]*mat[2, 2]*mat[1, 3] + mat[0, 2]*mat[3, 1]*mat[0, 2]*mat[1, 3]
        - mat[3, 0]*mat[2, 1]*mat[0, 2]*mat[1, 3] + mat[0, 0]*mat[2, 1]*mat[3, 2]*mat[1, 3] - mat[0, 2]*mat[0, 1]*mat[3, 2]*mat[1, 3]
        + mat[1, 0]*mat[0, 1]*mat[3, 2]*mat[2, 3] - mat[0, 0]*mat[1, 1]*mat[3, 2]*mat[2, 3] + mat[3, 0]*mat[1, 1]*mat[0, 2]*mat[2, 3]
        - mat[1, 0]*mat[3, 1]*mat[0, 2]*mat[2, 3] + mat[0, 0]*mat[3, 1]*mat[1, 2]*mat[2, 3] - mat[3, 0]*mat[0, 1]*mat[1, 2]*mat[2, 3]
    #endif
}

public func determinant(_ mat: Mat3x3d) -> Double {
    #if FRB_MATH_USE_SIMD
    return simd.simd_determinant(mat.storage)
    #else
    return (mat[0, 0] * mat[1, 1] * mat[2, 2] + mat[0, 1] * mat[1, 2] * mat[2, 0] + mat[0, 2] * mat[1, 0] * mat[2, 1])
        - (mat[0, 2] * mat[1, 1] * mat[2, 0] + mat[0, 0] * mat[1, 2] * mat[2, 1] + mat[0, 1] * mat[1, 0] * mat[2, 2])
    #endif
}
