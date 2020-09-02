//
//  inverse.swift
//
//
//  Created by Christian Treffs on 09.09.19.
//

#if FRB_MATH_USE_SIMD
import func simd.simd_inverse
#endif

public func inverse(_ matrix: Mat4x4f) -> Mat4x4f {
    #if FRB_MATH_USE_SIMD
    return Mat4x4f(storage: simd.simd_inverse(matrix.storage))
    #else
    let adj: Mat4x4f = adjugate(matrix)
    let value: Float = 1.0 / determinant(adj)
    return multiply(value, adj)
    #endif
}

public func inverse(_ matrix: Mat4x4d) -> Mat4x4d {
    #if FRB_MATH_USE_SIMD
    return Mat4x4d(storage: simd.simd_inverse(matrix.storage))
    #else
    let adj: Mat4x4d = adjugate(matrix)
    let value: Double = 1.0 / determinant(adj)
    return multiply(value, adj)
    #endif
}
