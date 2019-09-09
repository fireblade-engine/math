//
//  File.swift
//
//
//  Created by Christian Treffs on 09.09.19.
//
#if canImport(simd)
import func simd.simd_quaternion
#endif

public func quaternion(angle: Float, axis: SIMD3<Float>) -> Quat4f {
    #if USE_SIMD
    return Quat4f(storage: simd_quaternion(angle, axis))
    #else
    fatalError("implementation missind \(#function)")
    #endif
}

public func quaternion(angle: Double, axis: SIMD3<Double>) -> Quat4d {
    #if USE_SIMD
    return Quat4d(storage: simd_quaternion(angle, axis))
    #else
    fatalError("implementation missind \(#function)")
    #endif
}

public func quaternion(matrix: Mat3x3f) -> Quat4f {
    #if USE_SIMD
    return Quat4f(storage: simd_quaternion(matrix.storage))
    #else
    fatalError("implementation missind \(#function)")
    #endif
}

public func quaternion(matrix: Mat3x3d) -> Quat4d {
    #if USE_SIMD
    return Quat4d(storage: simd_quaternion(matrix.storage))
    #else
    fatalError("implementation missind \(#function)")
    #endif
}

public func quaternion(matrix: Mat4x4f) -> Quat4f {
    #if USE_SIMD
    return Quat4f(storage: simd_quaternion(matrix.storage))
    #else
    fatalError("implementation missind \(#function)")
    #endif
}

public func quaternion(matrix: Mat4x4d) -> Quat4d {
    #if USE_SIMD
    return Quat4d(storage: simd_quaternion(matrix.storage))
    #else
    fatalError("implementation missind \(#function)")
    #endif
}
