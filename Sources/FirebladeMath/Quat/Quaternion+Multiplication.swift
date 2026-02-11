#if FRB_MATH_USE_SIMD
import func simd.simd_act
import func simd.simd_add
import func simd.simd_mul
import func simd.simd_sub
#endif

/// Multiplies a scalar and a quaternion.
public func multiply(_ lhs: Float, _ rhs: Quat4f) -> Quat4f {
    #if FRB_MATH_USE_SIMD
    return Quat4f(storage: simd.simd_mul(lhs, rhs.storage))
    #else
    return Quat4f(lhs * rhs.x, lhs * rhs.y, lhs * rhs.z, lhs * rhs.w)
    #endif
}

/// Multiplies a quaternion and a scalar.
public func multiply(_ lhs: Quat4f, _ rhs: Float) -> Quat4f {
    #if FRB_MATH_USE_SIMD
    return Quat4f(storage: simd.simd_mul(lhs.storage, rhs))
    #else
    return Quat4f(lhs.x * rhs, lhs.y * rhs, lhs.z * rhs, lhs.w * rhs)
    #endif
}

/// Returns the product of two quaternions.
public func multiply(_ lhs: Quat4f, _ rhs: Quat4f) -> Quat4f {
    #if FRB_MATH_USE_SIMD
    return Quat4f(storage: simd.simd_mul(lhs.storage, rhs.storage))
    #else
    let n0 = lhs.w * rhs.w - lhs.x * rhs.x - lhs.y * rhs.y - lhs.z * rhs.z
    let n1 = lhs.w * rhs.x + lhs.x * rhs.w + lhs.y * rhs.z - lhs.z * rhs.y
    let n2 = lhs.w * rhs.y - lhs.x * rhs.z + lhs.y * rhs.w + lhs.z * rhs.x
    let n3 = lhs.w * rhs.z + lhs.x * rhs.y - lhs.y * rhs.x + lhs.z * rhs.w
    return Quat4f(n1, n2, n3, n0)
    #endif
}

/// Returns the sum of two quaternions.
public func add(_ lhs: Quat4f, _ rhs: Quat4f) -> Quat4f {
    #if FRB_MATH_USE_SIMD
    return Quat4f(storage: simd.simd_add(lhs.storage, rhs.storage))
    #else
    return Quat4f(
        lhs.x + rhs.x,
        lhs.y + rhs.y,
        lhs.z + rhs.z,
        lhs.w + rhs.w
    )
    #endif
}

/// Returns the difference of two quaternions.
public func subtract(_ lhs: Quat4f, _ rhs: Quat4f) -> Quat4f {
    #if FRB_MATH_USE_SIMD
    return Quat4f(storage: simd.simd_sub(lhs.storage, rhs.storage))
    #else
    return Quat4f(
        lhs.x - rhs.x,
        lhs.y - rhs.y,
        lhs.z - rhs.z,
        lhs.w - rhs.w
    )
    #endif
}

/// Returns a vector rotated by a quaternion.
///
/// - Parameters:
///   - lhs: the rotation quaternion (will be normalized).
///   - rhs: the vector to be rotated.
/// - Returns: the rotated vector.
public func act(_ lhs: Quat4f, _ rhs: Vec3f) -> Vec3f {
    #if FRB_MATH_USE_SIMD
    return simd.simd_act(lhs.normalized.storage, rhs)
    #else
    let lNorm = lhs.normalized
    let imag = Vec3f(lNorm.x, lNorm.y, lNorm.z)
    let t: Vec3f = 2.0 * cross(imag, rhs)
    return rhs + (lNorm.w * t) + cross(imag, t)
    #endif
}

/// Returns a vector rotated by a quaternion.
///
/// - Parameters:
///   - lhs: the rotation quaternion (will be normalized).
///   - rhs: the vector to be rotated.
/// - Returns: the rotated vector.
public func act(_ lhs: Quat4d, _ rhs: Vec3d) -> Vec3d {
    #if FRB_MATH_USE_SIMD
    return simd.simd_act(lhs.normalized.storage, rhs)
    #else
    let lNorm = lhs.normalized
    let imag = Vec3d(lNorm.x, lNorm.y, lNorm.z)
    let t: Vec3d = 2.0 * cross(imag, rhs)
    return rhs + (lNorm.w * t) + cross(imag, t)
    #endif
}

/// Multiplies a scalar and a quaternion.
public func multiply(_ lhs: Double, _ rhs: Quat4d) -> Quat4d {
    #if FRB_MATH_USE_SIMD
    return Quat4d(storage: simd.simd_mul(lhs, rhs.storage))
    #else
    return Quat4d(lhs * rhs.x, lhs * rhs.y, lhs * rhs.z, lhs * rhs.w)
    #endif
}

/// Multiplies a quaternion and a scalar.
public func multiply(_ lhs: Quat4d, _ rhs: Double) -> Quat4d {
    #if FRB_MATH_USE_SIMD
    return Quat4d(storage: simd.simd_mul(lhs.storage, rhs))
    #else
    return Quat4d(lhs.x * rhs, lhs.y * rhs, lhs.z * rhs, lhs.w * rhs)
    #endif
}

/// Returns the product of two quaternions.
public func multiply(_ lhs: Quat4d, _ rhs: Quat4d) -> Quat4d {
    #if FRB_MATH_USE_SIMD
    return Quat4d(storage: simd.simd_mul(lhs.storage, rhs.storage))
    #else
    let n0 = lhs.w * rhs.w - lhs.x * rhs.x - lhs.y * rhs.y - lhs.z * rhs.z
    let n1 = lhs.w * rhs.x + lhs.x * rhs.w + lhs.y * rhs.z - lhs.z * rhs.y
    let n2 = lhs.w * rhs.y - lhs.x * rhs.z + lhs.y * rhs.w + lhs.z * rhs.x
    let n3 = lhs.w * rhs.z + lhs.x * rhs.y - lhs.y * rhs.x + lhs.z * rhs.w
    return Quat4d(n1, n2, n3, n0)
    #endif
}

/// Returns the sum of two quaternions.
public func add(_ lhs: Quat4d, _ rhs: Quat4d) -> Quat4d {
    #if FRB_MATH_USE_SIMD
    return Quat4d(storage: simd.simd_add(lhs.storage, rhs.storage))
    #else
    return Quat4d(
        lhs.x + rhs.x,
        lhs.y + rhs.y,
        lhs.z + rhs.z,
        lhs.w + rhs.w
    )
    #endif
}

/// Returns the difference of two quaternions.
public func subtract(_ lhs: Quat4d, _ rhs: Quat4d) -> Quat4d {
    #if FRB_MATH_USE_SIMD
    return Quat4d(storage: simd.simd_sub(lhs.storage, rhs.storage))
    #else
    return Quat4d(
        lhs.x - rhs.x,
        lhs.y - rhs.y,
        lhs.z - rhs.z,
        lhs.w - rhs.w
    )
    #endif
}
