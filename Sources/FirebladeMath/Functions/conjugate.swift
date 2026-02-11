#if FRB_MATH_USE_SIMD
import func simd.simd_conjugate
#endif

/// Returns the conjugate of a quaternion.
/// - Parameter quat: The quaternion.
/// - Returns: The conjugate of the quaternion.
public func conjugate(_ quat: Quat4f) -> Quat4f {
    #if FRB_MATH_USE_SIMD
    return Quat4f(storage: simd.simd_conjugate(quat.storage))
    #else
    return Quat4f(Vec4f(quat) * Vec4f(-1, -1, -1, 1))
    #endif
}

/// Returns the conjugate of a quaternion.
/// - Parameter quat: The quaternion.
/// - Returns: The conjugate of the quaternion.
public func conjugate(_ quat: Quat4d) -> Quat4d {
    #if FRB_MATH_USE_SIMD
    return Quat4d(storage: simd.simd_conjugate(quat.storage))
    #else
    return Quat4d(Vec4d(quat) * Vec4d(-1, -1, -1, 1))
    #endif
}
