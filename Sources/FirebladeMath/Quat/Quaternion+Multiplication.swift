//
//  Quaternion+Multiplication.swift
//  FirebladeMath
//
//  Created by Christian Treffs on 26.08.19.
//

#if FRB_MATH_USE_SIMD
import func simd.simd_mul
import func simd.simd_act
import func simd.simd_sub
import func simd.simd_add
#endif

public func multiply(_ lhs: Float, _ rhs: Quat4f) -> Quat4f {
    #if FRB_MATH_USE_SIMD
    return Quat4f(storage: simd.simd_mul(lhs, rhs.storage))
    #else
    return Quat4f(lhs * SIMD4<Float>(rhs.storage))
    #endif
}

public func multiply(_ lhs: Quat4f, _ rhs: Float) -> Quat4f {
    #if FRB_MATH_USE_SIMD
    return Quat4f(storage: simd.simd_mul(lhs.storage, rhs))
    #else
    return Quat4f(SIMD4<Float>(lhs.storage) * rhs)
    #endif
}

/// Returns the product of two quaternions.
public func multiply(_ lhs: Quat4f, _ rhs: Quat4f) -> Quat4f {
    #if FRB_MATH_USE_SIMD
    return Quat4f(storage: simd.simd_mul(lhs.storage, rhs.storage))
    #else
    let n0 = rhs.x * lhs.x - rhs.y * lhs.y - rhs.z * lhs.z - rhs.w * lhs.w
    let n1 = rhs.x * lhs.y + rhs.y * lhs.x - rhs.z * lhs.w + rhs.w * lhs.z
    let n2 = rhs.x * lhs.z + rhs.y * lhs.w + rhs.z * lhs.x - rhs.w * lhs.y
    let n3 = rhs.x * lhs.w - rhs.y * lhs.z + rhs.z * lhs.y + rhs.w * lhs.x
    return Quat4f(n3, n2, n1, n0)
    #endif
}

/// Returns the product of two quaternions.
public func multiply(_ lhs: Quat4d, _ rhs: Quat4d) -> Quat4d {
    #if FRB_MATH_USE_SIMD
    return Quat4d(storage: simd.simd_mul(lhs.storage, rhs.storage))
    #else
    let n0 = rhs.x * lhs.x - rhs.y * lhs.y - rhs.z * lhs.z - rhs.w * lhs.w
    let n1 = rhs.x * lhs.y + rhs.y * lhs.x - rhs.z * lhs.w + rhs.w * lhs.z
    let n2 = rhs.x * lhs.z + rhs.y * lhs.w + rhs.z * lhs.x - rhs.w * lhs.y
    let n3 = rhs.x * lhs.w - rhs.y * lhs.z + rhs.z * lhs.y + rhs.w * lhs.x
    return Quat4d(n3, n2, n1, n0)
    #endif
}

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
