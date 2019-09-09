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
    fatalError("implementation missing \(#function)")
    #endif
}

public func quaternion(angle: Double, axis: SIMD3<Double>) -> Quat4d {
    #if USE_SIMD
    return Quat4d(storage: simd_quaternion(angle, axis))
    #else
    fatalError("implementation missing \(#function)")
    #endif
}

/** @abstract Construct a quaternion that rotates from one vector to another.
 *
 *  @param from A normalized three-element vector.
 *  @param to A normalized three-element vector.
 *
 *  @discussion The rotation axis is `simd_cross(from, to)`. If `from` and
 *  `to` point in opposite directions (to within machine precision), an
 *  arbitrary rotation axis is chosen, and the angle is pi radians.           */
public func quaternion(from: SIMD3<Float>, to: SIMD3<Float>) -> Quat4f {
    #if USE_SIMD
    return Quat4f(storage: simd.simd_quaternion(from, to))
    #else
    fatalError("implementation missing \(#function)")
    #endif
}

public func quaternion(from: SIMD3<Double>, to: SIMD3<Double>) -> Quat4d {
    #if USE_SIMD
    return Quat4d(storage: simd.simd_quaternion(from, to))
    #else
    fatalError("implementation missing \(#function)")
    #endif
}

public func quaternion(matrix: Mat3x3f) -> Quat4f {
    #if USE_SIMD
    return Quat4f(storage: simd_quaternion(matrix.storage))
    #else
    fatalError("implementation missing \(#function)")
    #endif
}

public func quaternion(matrix: Mat3x3d) -> Quat4d {
    #if USE_SIMD
    return Quat4d(storage: simd_quaternion(matrix.storage))
    #else
    fatalError("implementation missing \(#function)")
    #endif
}

public func quaternion(matrix: Mat4x4f) -> Quat4f {
    #if USE_SIMD
    return Quat4f(storage: simd_quaternion(matrix.storage))
    #else
    fatalError("implementation missing \(#function)")
    #endif
}

public func quaternion(matrix: Mat4x4d) -> Quat4d {
    #if USE_SIMD
    return Quat4d(storage: simd_quaternion(matrix.storage))
    #else
    fatalError("implementation missing \(#function)")
    #endif
}
