#if FRB_MATH_USE_SIMD
import func simd.simd_act
import func simd.simd_add
import func simd.simd_mul
import func simd.simd_sub
#endif

/// Multiplies a scalar and a quaternion.
@inlinable
@inline(__always)
public func multiply(_ lhs: Float, _ rhs: Quat4f) -> Quat4f {
    #if FRB_MATH_USE_SIMD
    return Quat4f(storage: simd.simd_mul(lhs, rhs.storage))
    #else
    return Quat4f(lhs * rhs.x, lhs * rhs.y, lhs * rhs.z, lhs * rhs.w)
    #endif
}

/// Multiplies a quaternion and a scalar.
@inlinable
@inline(__always)
public func multiply(_ lhs: Quat4f, _ rhs: Float) -> Quat4f {
    #if FRB_MATH_USE_SIMD
    return Quat4f(storage: simd.simd_mul(lhs.storage, rhs))
    #else
    return Quat4f(lhs.x * rhs, lhs.y * rhs, lhs.z * rhs, lhs.w * rhs)
    #endif
}

/// Returns the product of two quaternions.
@inlinable
public func multiply(_ lhs: Quat4f, _ rhs: Quat4f) -> Quat4f {
    #if FRB_MATH_USE_SIMD
    return Quat4f(storage: simd.simd_mul(lhs.storage, rhs.storage))
    #else
    // Hamilton product as four 4-wide multiply-adds over the [x, y, z, w] lanes.
    // Terms are explicitly typed so older compilers type-check them in reasonable time.
    let lv: Vec4f = lhs.storage.storage
    let rv: Vec4f = rhs.storage.storage
    let term0: Vec4f = Vec4f(repeating: lv.w) * rv
    let term1: Vec4f = Vec4f(lv.x, lv.y, lv.z, lv.x) * Vec4f(rv.w, rv.w, rv.w, -rv.x)
    let term2: Vec4f = Vec4f(lv.y, lv.z, lv.x, lv.y) * Vec4f(rv.z, rv.x, rv.y, -rv.y)
    let term3: Vec4f = Vec4f(lv.z, lv.x, lv.y, lv.z) * Vec4f(rv.y, rv.z, rv.x, rv.z)
    let product: Vec4f = (term0 + term1) + (term2 - term3)
    return Quat4f(product)
    #endif
}

/// Returns the sum of two quaternions.
@inlinable
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
@inlinable
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
@inlinable
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
@inlinable
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
@inlinable
@inline(__always)
public func multiply(_ lhs: Double, _ rhs: Quat4d) -> Quat4d {
    #if FRB_MATH_USE_SIMD
    return Quat4d(storage: simd.simd_mul(lhs, rhs.storage))
    #else
    return Quat4d(lhs * rhs.x, lhs * rhs.y, lhs * rhs.z, lhs * rhs.w)
    #endif
}

/// Multiplies a quaternion and a scalar.
@inlinable
@inline(__always)
public func multiply(_ lhs: Quat4d, _ rhs: Double) -> Quat4d {
    #if FRB_MATH_USE_SIMD
    return Quat4d(storage: simd.simd_mul(lhs.storage, rhs))
    #else
    return Quat4d(lhs.x * rhs, lhs.y * rhs, lhs.z * rhs, lhs.w * rhs)
    #endif
}

/// Returns the product of two quaternions.
@inlinable
public func multiply(_ lhs: Quat4d, _ rhs: Quat4d) -> Quat4d {
    #if FRB_MATH_USE_SIMD
    return Quat4d(storage: simd.simd_mul(lhs.storage, rhs.storage))
    #else
    // Hamilton product as four 4-wide multiply-adds over the [x, y, z, w] lanes.
    // Terms are explicitly typed so older compilers type-check them in reasonable time.
    let lv: Vec4d = lhs.storage.storage
    let rv: Vec4d = rhs.storage.storage
    let term0: Vec4d = Vec4d(repeating: lv.w) * rv
    let term1: Vec4d = Vec4d(lv.x, lv.y, lv.z, lv.x) * Vec4d(rv.w, rv.w, rv.w, -rv.x)
    let term2: Vec4d = Vec4d(lv.y, lv.z, lv.x, lv.y) * Vec4d(rv.z, rv.x, rv.y, -rv.y)
    let term3: Vec4d = Vec4d(lv.z, lv.x, lv.y, lv.z) * Vec4d(rv.y, rv.z, rv.x, rv.z)
    let product: Vec4d = (term0 + term1) + (term2 - term3)
    return Quat4d(product)
    #endif
}

/// Returns the sum of two quaternions.
@inlinable
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
@inlinable
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
