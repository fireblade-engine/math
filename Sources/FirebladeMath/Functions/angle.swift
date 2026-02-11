#if FRB_MATH_USE_SIMD
import func simd.simd_angle
#endif

/// Returns the angle by which a quaternion rotates.
/// - Parameter quat: The quaternion.
/// - Returns: The angle in radians.
public func angle(_ quat: Quat4f) -> Float {
    #if FRB_MATH_USE_SIMD
    return simd.simd_angle(quat.storage)
    #else
    let vecLen = sqrt(quat.x * quat.x + quat.y * quat.y + quat.z * quat.z)
    return 2.0 * atan2(vecLen, quat.w)
    #endif
}

/// Returns the angle by which a quaternion rotates.
/// - Parameter quat: The quaternion.
/// - Returns: The angle in radians.
public func angle(_ quat: Quat4d) -> Double {
    #if FRB_MATH_USE_SIMD
    return simd.simd_angle(quat.storage)
    #else
    let vecLen = sqrt(quat.x * quat.x + quat.y * quat.y + quat.z * quat.z)
    return 2.0 * atan2(vecLen, quat.w)
    #endif
}
