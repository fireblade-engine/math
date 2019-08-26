//
//  Quaternion+Multiplication.swift
//  FirebladeMath
//
//  Created by Christian Treffs on 26.08.19.
//

#if canImport(simd)
import func simd.simd_mul
import func simd.simd_act
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

/// Returns a vector rotated by a quaternion.
public func act(_ lhs: Quat4f, _ rhs: Vec3f) -> Vec3f {
    #if canImport(simd)
    return simd.simd_act(lhs, rhs)
    #else
    fatalError("not implemented yet")
    #endif
}
