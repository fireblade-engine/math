#if FRB_MATH_USE_SIMD
import func simd.simd_matrix3x3
import func simd.simd_matrix4x4
#endif

public func matrix3x3(from quat: Quat4f) -> Mat3x3f {
    #if FRB_MATH_USE_SIMD
    return Mat3x3f(storage: simd_matrix3x3(quat.storage))
    #else
    let v = Vec4f(quat)
    return Mat3x3f(
        Vec3f(1 - 2 * (v.y * v.y + v.z * v.z),
              2 * (v.x * v.y + v.z * v.w),
              2 * (v.x * v.z - v.y * v.w)),
        Vec3f(2 * (v.x * v.y - v.z * v.w),
              1 - 2 * (v.z * v.z + v.x * v.x),
              2 * (v.y * v.z + v.x * v.w)),
        Vec3f(2 * (v.z * v.x + v.y * v.w),
              2 * (v.y * v.z - v.x * v.w),
              1 - 2 * (v.y * v.y + v.x * v.x))
    )
    #endif
}

public func matrix3x3(from quat: Quat4d) -> Mat3x3d {
    #if FRB_MATH_USE_SIMD
    return Mat3x3d(storage: simd_matrix3x3(quat.storage))
    #else
    let v = Vec4d(quat)
    return Mat3x3d(
        Vec3d(1 - 2 * (v.y * v.y + v.z * v.z),
              2 * (v.x * v.y + v.z * v.w),
              2 * (v.x * v.z - v.y * v.w)),
        Vec3d(2 * (v.x * v.y - v.z * v.w),
              1 - 2 * (v.z * v.z + v.x * v.x),
              2 * (v.y * v.z + v.x * v.w)),
        Vec3d(2 * (v.z * v.x + v.y * v.w),
              2 * (v.y * v.z - v.x * v.w),
              1 - 2 * (v.y * v.y + v.x * v.x))
    )
    #endif
}

public func matrix4x4(from quat: Quat4f) -> Mat4x4f {
    #if FRB_MATH_USE_SIMD
    return Mat4x4f(storage: simd_matrix4x4(quat.storage))
    #else
    let v = Vec4f(quat)
    return Mat4x4f(
        Vec4f(1 - 2 * (v.y * v.y + v.z * v.z),
              2 * (v.x * v.y + v.z * v.w),
              2 * (v.x * v.z - v.y * v.w), 0),
        Vec4f(2 * (v.x * v.y - v.z * v.w),
              1 - 2 * (v.z * v.z + v.x * v.x),
              2 * (v.y * v.z + v.x * v.w), 0),
        Vec4f(2 * (v.z * v.x + v.y * v.w),
              2 * (v.y * v.z - v.x * v.w),
              1 - 2 * (v.y * v.y + v.x * v.x), 0),
        Vec4f(0, 0, 0, 1)
    )
    #endif
}

public func matrix4x4(from quat: Quat4d) -> Mat4x4d {
    #if FRB_MATH_USE_SIMD
    return Mat4x4d(storage: simd_matrix4x4(quat.storage))
    #else
    let v = Vec4d(quat)
    return Mat4x4d(
        Vec4d(1 - 2 * (v.y * v.y + v.z * v.z),
              2 * (v.x * v.y + v.z * v.w),
              2 * (v.x * v.z - v.y * v.w), 0),
        Vec4d(2 * (v.x * v.y - v.z * v.w),
              1 - 2 * (v.z * v.z + v.x * v.x),
              2 * (v.y * v.z + v.x * v.w), 0),
        Vec4d(2 * (v.z * v.x + v.y * v.w),
              2 * (v.y * v.z - v.x * v.w),
              1 - 2 * (v.y * v.y + v.x * v.x), 0),
        Vec4d(0, 0, 0, 1)
    )
    #endif
}
