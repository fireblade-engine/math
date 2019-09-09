//
//  File.swift
//
//
//  Created by Christian Treffs on 09.09.19.
//

#if canImport(simd)
import func simd.simd_matrix3x3
import func simd.simd_matrix4x4
#endif

public func matrix3x3(from quat: Quat4f) -> Mat3x3f {
    #if USE_SIMD
    return Mat3x3f(storage: simd_matrix3x3(quat.storage))
    #else
    fatalError("implementation missing \(#function)")
    #endif
}

public func matrix3x3(from quat: Quat4d) -> Mat3x3d {
    #if USE_SIMD
    return Mat3x3d(storage: simd_matrix3x3(quat.storage))
    #else
    fatalError("implementation missing \(#function)")
    #endif
}

public func matrix4x4(from quat: Quat4f) -> Mat4x4f {
    #if USE_SIMD
    return Mat4x4f(storage: simd_matrix4x4(quat.storage))
    #else
    fatalError("implementation missing \(#function)")
    #endif
}

public func matrix4x4(from quat: Quat4d) -> Mat4x4d {
    #if USE_SIMD
    return Mat4x4d(storage: simd_matrix4x4(quat.storage))
    #else
    fatalError("implementation missing \(#function)")
    #endif
}
