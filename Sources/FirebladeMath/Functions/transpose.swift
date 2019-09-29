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
    fatalError("implementation missing \(#function)")
    #endif
}

public func transpose(_ matrix: Mat3x3d) -> Mat3x3d {
    #if USE_SIMD
    return Mat3x3d(storage: simd.simd_transpose(matrix.storage))
    #else
    fatalError("implementation missing \(#function)")
    #endif
}

public func transpose(_ matrix: Mat4x4f) -> Mat4x4f {
    #if USE_SIMD
    return Mat4x4f(storage: simd.simd_transpose(matrix.storage))
    #else
    fatalError("implementation missing \(#function)")
    #endif
}

public func transpose(_ matrix: Mat4x4d) -> Mat4x4d {
    #if USE_SIMD
    return Mat4x4d(storage: simd.simd_transpose(matrix.storage))
    #else
    fatalError("implementation missing \(#function)")
    #endif
}
