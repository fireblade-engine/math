//
//  axis.swift
//
//
//  Created by Christian Treffs on 09.09.19.
//
#if FRB_MATH_USE_SIMD
import func simd.simd_axis
#endif

/// Returns the axis about which a quaternion rotates.
/// - Parameter quat: The quaternion.
/// - Returns: The normalized axis of rotation.
@inlinable
public func axis(_ quat: Quat4f) -> SIMD3<Float> {
    #if FRB_MATH_USE_SIMD
    return simd.simd_axis(quat.storage)
    #else
    return normalize(Vec3f(quat.x, quat.y, quat.z))
    #endif
}

/// Returns the axis about which a quaternion rotates.
/// - Parameter quat: The quaternion.
/// - Returns: The normalized axis of rotation.
@inlinable
public func axis(_ quat: Quat4d) -> SIMD3<Double> {
    #if FRB_MATH_USE_SIMD
    return simd.simd_axis(quat.storage)
    #else
    return normalize(Vec3d(quat.x, quat.y, quat.z))
    #endif
}
