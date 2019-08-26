//
//  Matrix+Multiplication.swift
//  FirebladeMath
//
//  Created by Christian Treffs on 26.08.19.
//

#if canImport(simd)
import func simd.simd_mul
#endif

// MARK: - Mat4x4d
public func multiply(_ lhs: Mat4x4d, _ rhs: Mat4x4d) -> Mat4x4d {
    #if canImport(simd)
    return simd_mul(lhs, rhs)
    #else
    #error("missing implementation")
    #endif
}

public func multiply(_ lhs: Double, _ rhs: Mat4x4d) -> Mat4x4d {
    #if canImport(simd)
    return simd_mul(lhs, rhs)
    #else
    #error("missing implementation")
    #endif
}

public func multiply(_ lhs: Vec4d, _ rhs: Mat4x4d) -> Vec4d {
    #if canImport(simd)
    return simd_mul(lhs, rhs)
    #else
    #error("missing implementation")
    #endif
}

public func multiply(_ lhs: Mat4x4d, _ rhs: Vec4d) -> Vec4d {
    #if canImport(simd)
    return simd_mul(lhs, rhs)
    #else
    #error("missing implementation")
    #endif
}

// MARK: - Mat4x4f
public func multiply(_ lhs: Mat4x4f, _ rhs: Mat4x4f) -> Mat4x4f {
    #if canImport(simd)
    return simd_mul(lhs, rhs)
    #else
    #error("missing implementation")
    #endif
}

public func multiply(_ lhs: Float, _ rhs: Mat4x4f) -> Mat4x4f {
    #if canImport(simd)
    return simd_mul(lhs, rhs)
    #else
    #error("missing implementation")
    #endif
}

public func multiply(_ lhs: Vec4f, _ rhs: Mat4x4f) -> Vec4f {
    #if canImport(simd)
    return simd_mul(lhs, rhs)
    #else
    #error("missing implementation")
    #endif
}

public func multiply(_ lhs: Mat4x4f, _ rhs: Vec4f) -> Vec4f {
    #if canImport(simd)
    return simd_mul(lhs, rhs)
    #else
    #error("missing implementation")
    #endif
}
