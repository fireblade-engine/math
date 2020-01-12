//
//  Transpose.swift
//
//
//  Created by Christian Treffs on 29.09.19.
//

#if canImport(simd)
import func simd.simd_transpose
#endif

public func transpose(_ matrix: Mat3x3f) -> Mat3x3f {
    #if USE_SIMD
    return Mat3x3f(storage: simd.simd_transpose(matrix.storage))
    #else
    return Mat3x3f([
        matrix[0, 0], matrix[1, 0], matrix[2, 0],
        matrix[0, 1], matrix[1, 1], matrix[2, 1],
        matrix[0, 2], matrix[1, 2], matrix[2, 2]
    ])
    #endif
}

public func transpose(_ matrix: Mat3x3d) -> Mat3x3d {
    #if USE_SIMD
    return Mat3x3d(storage: simd.simd_transpose(matrix.storage))
    #else
    return Mat3x3d([
        matrix[0, 0], matrix[1, 0], matrix[2, 0],
        matrix[0, 1], matrix[1, 1], matrix[2, 1],
        matrix[0, 2], matrix[1, 2], matrix[2, 2]
    ])
    #endif
}

public func transpose(_ matrix: Mat4x4f) -> Mat4x4f {
    #if USE_SIMD
    return Mat4x4f(storage: simd.simd_transpose(matrix.storage))
    #else
    return Mat4x4f([
        matrix[0, 0], matrix[1, 0], matrix[2, 0], matrix[3, 0],
        matrix[0, 1], matrix[1, 1], matrix[2, 1], matrix[3, 1],
        matrix[0, 2], matrix[1, 2], matrix[2, 2], matrix[3, 2],
        matrix[0, 3], matrix[1, 3], matrix[2, 3], matrix[3, 3]
    ])
    #endif
}

public func transpose(_ matrix: Mat4x4d) -> Mat4x4d {
    #if USE_SIMD
    return Mat4x4d(storage: simd.simd_transpose(matrix.storage))
    #else
    return Mat4x4d([
        matrix[0, 0], matrix[1, 0], matrix[2, 0], matrix[3, 0],
        matrix[0, 1], matrix[1, 1], matrix[2, 1], matrix[3, 1],
        matrix[0, 2], matrix[1, 2], matrix[2, 2], matrix[3, 2],
        matrix[0, 3], matrix[1, 3], matrix[2, 3], matrix[3, 3]
    ])
    #endif
}
