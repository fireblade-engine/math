#if FRB_MATH_USE_SIMD
import func simd.simd_matrix3x3
import func simd.simd_matrix4x4
#endif

/// Creates a 3x3 rotation matrix from a quaternion.
/// - Parameter quat: The quaternion.
/// - Returns: The 3x3 rotation matrix.
@inlinable
public func matrix3x3(from quat: Quat4f) -> Mat3x3f {
    #if FRB_MATH_USE_SIMD
    return Mat3x3f(storage: simd_matrix3x3(quat.storage))
    #else
    let v = Vec4f(quat)
    // Same diagonal as Apple's simd_matrix3x3/simd_matrix4x4, so non-unit quaternions
    // produce the same (scaled) matrix on every platform.
    let xx: Float = v.x * v.x, yy: Float = v.y * v.y, zz: Float = v.z * v.z, ww: Float = v.w * v.w
    return Mat3x3f(
        Vec3f(xx - yy - zz + ww,
              2 * (v.x * v.y + v.z * v.w),
              2 * (v.x * v.z - v.y * v.w)),
        Vec3f(2 * (v.x * v.y - v.z * v.w),
              yy - zz + ww - xx,
              2 * (v.y * v.z + v.x * v.w)),
        Vec3f(2 * (v.z * v.x + v.y * v.w),
              2 * (v.y * v.z - v.x * v.w),
              zz + ww - xx - yy)
    )
    #endif
}

/// Creates a 3x3 rotation matrix from a quaternion.
/// - Parameter quat: The quaternion.
/// - Returns: The 3x3 rotation matrix.
@inlinable
public func matrix3x3(from quat: Quat4d) -> Mat3x3d {
    #if FRB_MATH_USE_SIMD
    return Mat3x3d(storage: simd_matrix3x3(quat.storage))
    #else
    let v = Vec4d(quat)
    // Same diagonal as Apple's simd_matrix3x3/simd_matrix4x4, so non-unit quaternions
    // produce the same (scaled) matrix on every platform.
    let xx: Double = v.x * v.x, yy: Double = v.y * v.y, zz: Double = v.z * v.z, ww: Double = v.w * v.w
    return Mat3x3d(
        Vec3d(xx - yy - zz + ww,
              2 * (v.x * v.y + v.z * v.w),
              2 * (v.x * v.z - v.y * v.w)),
        Vec3d(2 * (v.x * v.y - v.z * v.w),
              yy - zz + ww - xx,
              2 * (v.y * v.z + v.x * v.w)),
        Vec3d(2 * (v.z * v.x + v.y * v.w),
              2 * (v.y * v.z - v.x * v.w),
              zz + ww - xx - yy)
    )
    #endif
}

/// Creates a 4x4 rotation matrix from a quaternion.
/// - Parameter quat: The quaternion.
/// - Returns: The 4x4 rotation matrix.
@inlinable
public func matrix4x4(from quat: Quat4f) -> Mat4x4f {
    #if FRB_MATH_USE_SIMD
    return Mat4x4f(storage: simd_matrix4x4(quat.storage))
    #else
    let v = Vec4f(quat)
    // Same diagonal as Apple's simd_matrix3x3/simd_matrix4x4, so non-unit quaternions
    // produce the same (scaled) matrix on every platform.
    let xx: Float = v.x * v.x, yy: Float = v.y * v.y, zz: Float = v.z * v.z, ww: Float = v.w * v.w
    return Mat4x4f(
        Vec4f(
            xx - yy - zz + ww,
            2 * (v.x * v.y + v.z * v.w),
            2 * (v.x * v.z - v.y * v.w),
            0
        ),
        Vec4f(
            2 * (v.x * v.y - v.z * v.w),
            yy - zz + ww - xx,
            2 * (v.y * v.z + v.x * v.w),
            0
        ),
        Vec4f(
            2 * (v.z * v.x + v.y * v.w),
            2 * (v.y * v.z - v.x * v.w),
            zz + ww - xx - yy,
            0
        ),
        Vec4f(0, 0, 0, 1)
    )
    #endif
}

/// Creates a 4x4 rotation matrix from a quaternion.
/// - Parameter quat: The quaternion.
/// - Returns: The 4x4 rotation matrix.
@inlinable
public func matrix4x4(from quat: Quat4d) -> Mat4x4d {
    #if FRB_MATH_USE_SIMD
    return Mat4x4d(storage: simd_matrix4x4(quat.storage))
    #else
    let v = Vec4d(quat)
    // Same diagonal as Apple's simd_matrix3x3/simd_matrix4x4, so non-unit quaternions
    // produce the same (scaled) matrix on every platform.
    let xx: Double = v.x * v.x, yy: Double = v.y * v.y, zz: Double = v.z * v.z, ww: Double = v.w * v.w
    return Mat4x4d(
        Vec4d(
            xx - yy - zz + ww,
            2 * (v.x * v.y + v.z * v.w),
            2 * (v.x * v.z - v.y * v.w),
            0
        ),
        Vec4d(
            2 * (v.x * v.y - v.z * v.w),
            yy - zz + ww - xx,
            2 * (v.y * v.z + v.x * v.w),
            0
        ),
        Vec4d(
            2 * (v.z * v.x + v.y * v.w),
            2 * (v.y * v.z - v.x * v.w),
            zz + ww - xx - yy,
            0
        ),
        Vec4d(0, 0, 0, 1)
    )
    #endif
}
