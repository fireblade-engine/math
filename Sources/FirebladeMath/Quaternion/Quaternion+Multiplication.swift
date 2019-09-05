//
//  Quaternion+Multiplication.swift
//  FirebladeMath
//
//  Created by Christian Treffs on 26.08.19.
//

#if canImport(simd)
import func simd.simd_mul
import func simd.simd_act
import func simd.simd_sub
import func simd.simd_add
#endif

public func multiply(_ lhs: Float, _ rhs: Quat4f) -> Quat4f {
    #if canImport(simd)
    return simd.simd_mul(lhs, rhs)
    #else
    fatalError("not implemented yet")
    #endif
}

public func multiply(_ lhs: Quat4f, _ rhs: Float) -> Quat4f {
    #if canImport(simd)
    return simd.simd_mul(lhs, rhs)
    #else
    fatalError("not implemented yet")
    #endif
}

/// Returns the product of two quaternions.
public func multiply (_ lhs: Quat4f, _ rhs: Quat4f) -> Quat4f {
    #if canImport(simd)
    return simd.simd_mul(lhs, rhs)
    #else
    fatalError("not implemented yet")
    #endif
}

public func add(_ lhs: Quat4f, _ rhs: Quat4f) -> Quat4f {
    #if canImport(simd)
    return simd.simd_add(lhs, rhs)
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
    #if canImport(simd)
    return simd.simd_sub(lhs, rhs)
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
    #if canImport(simd)
    return simd.simd_act(lhs.normalized, rhs)
    #else
    fatalError("not implemented yet")
    #endif
}
