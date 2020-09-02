//
//  Matrix+Multiplication.swift
//  FirebladeMath
//
//  Created by Christian Treffs on 26.08.19.
//

#if FRB_MATH_USE_SIMD
import func simd.simd_mul
#endif

// MARK: - Mat4x4d
@inlinable
public func multiply(_ lhs: Mat4x4d, _ rhs: Mat4x4d) -> Mat4x4d {
    #if FRB_MATH_USE_SIMD
    return Mat4x4d(storage: simd_mul(lhs.storage, rhs.storage))
    #else
    return Mat4x4d(
        Vec4d(
            lhs[0] * rhs[0]  + lhs[4] * rhs[1]  + lhs[8] * rhs[2]   + lhs[12] * rhs[3],
            lhs[1] * rhs[0]  + lhs[5] * rhs[1]  + lhs[9] * rhs[2]   + lhs[13] * rhs[3],
            lhs[2] * rhs[0]  + lhs[6] * rhs[1]  + lhs[10] * rhs[2]  + lhs[14] * rhs[3],
            lhs[3] * rhs[0]  + lhs[7] * rhs[1]  + lhs[11] * rhs[2]  + lhs[15] * rhs[3]
        ),
        Vec4d(
            lhs[0] * rhs[4]  + lhs[4] * rhs[5]  + lhs[8] * rhs[6]   + lhs[12] * rhs[7],
            lhs[1] * rhs[4]  + lhs[5] * rhs[5]  + lhs[9] * rhs[6]   + lhs[13] * rhs[7],
            lhs[2] * rhs[4]  + lhs[6] * rhs[5]  + lhs[10] * rhs[6]  + lhs[14] * rhs[7],
            lhs[3] * rhs[4]  + lhs[7] * rhs[5]  + lhs[11] * rhs[6]  + lhs[15] * rhs[7]
        ),
        Vec4d(
            lhs[0] * rhs[8]  + lhs[4] * rhs[9]  + lhs[8] * rhs[10]  + lhs[12] * rhs[11],
            lhs[1] * rhs[8]  + lhs[5] * rhs[9]  + lhs[9] * rhs[10]  + lhs[13] * rhs[11],
            lhs[2] * rhs[8]  + lhs[6] * rhs[9]  + lhs[10] * rhs[10] + lhs[14] * rhs[11],
            lhs[3] * rhs[8]  + lhs[7] * rhs[9]  + lhs[11] * rhs[10] + lhs[15] * rhs[11]
        ),
        Vec4d(
            lhs[0] * rhs[12] + lhs[4] * rhs[13] + lhs[8] * rhs[14]  + lhs[12] * rhs[15],
            lhs[1] * rhs[12] + lhs[5] * rhs[13] + lhs[9] * rhs[14]  + lhs[13] * rhs[15],
            lhs[2] * rhs[12] + lhs[6] * rhs[13] + lhs[10] * rhs[14] + lhs[14] * rhs[15],
            lhs[3] * rhs[12] + lhs[7] * rhs[13] + lhs[11] * rhs[14] + lhs[15] * rhs[15]
        )
    )
    #endif
}

@inlinable
public func multiply(_ lhs: Double, _ rhs: Mat4x4d) -> Mat4x4d {
    #if FRB_MATH_USE_SIMD
    return Mat4x4d(storage: simd_mul(lhs, rhs.storage))
    #else
    #warning("implementation missing")
    return Mat4x4d.identity
    #endif
}

@inlinable
public func multiply(_ lhs: Vec4d, _ rhs: Mat4x4d) -> Vec4d {
    #if FRB_MATH_USE_SIMD
    return simd_mul(lhs, rhs.storage)
    #else
    #warning("implementation missing")
    return Vec4d.zero
    #endif
}

@inlinable
public func multiply(_ lhs: Mat4x4d, _ rhs: Vec4d) -> Vec4d {
    #if FRB_MATH_USE_SIMD
    return simd_mul(lhs.storage, rhs)
    #else
    #warning("implementation missing")
    return Vec4d.zero
    #endif
}

// MARK: - Mat4x4f
@inlinable
public func multiply(_ lhs: Mat4x4f, _ rhs: Mat4x4f) -> Mat4x4f {
    #if FRB_MATH_USE_SIMD
    return Mat4x4f(storage: simd_mul(lhs.storage, rhs.storage))
    #else
    return Mat4x4f(
        Vec4f(
            lhs[0] * rhs[0]  + lhs[4] * rhs[1]  + lhs[8] * rhs[2]   + lhs[12] * rhs[3],
            lhs[1] * rhs[0]  + lhs[5] * rhs[1]  + lhs[9] * rhs[2]   + lhs[13] * rhs[3],
            lhs[2] * rhs[0]  + lhs[6] * rhs[1]  + lhs[10] * rhs[2]  + lhs[14] * rhs[3],
            lhs[3] * rhs[0]  + lhs[7] * rhs[1]  + lhs[11] * rhs[2]  + lhs[15] * rhs[3]
        ),
        Vec4f(
            lhs[0] * rhs[4]  + lhs[4] * rhs[5]  + lhs[8] * rhs[6]   + lhs[12] * rhs[7],
            lhs[1] * rhs[4]  + lhs[5] * rhs[5]  + lhs[9] * rhs[6]   + lhs[13] * rhs[7],
            lhs[2] * rhs[4]  + lhs[6] * rhs[5]  + lhs[10] * rhs[6]  + lhs[14] * rhs[7],
            lhs[3] * rhs[4]  + lhs[7] * rhs[5]  + lhs[11] * rhs[6]  + lhs[15] * rhs[7]
        ),
        Vec4f(
            lhs[0] * rhs[8]  + lhs[4] * rhs[9]  + lhs[8] * rhs[10]  + lhs[12] * rhs[11],
            lhs[1] * rhs[8]  + lhs[5] * rhs[9]  + lhs[9] * rhs[10]  + lhs[13] * rhs[11],
            lhs[2] * rhs[8]  + lhs[6] * rhs[9]  + lhs[10] * rhs[10] + lhs[14] * rhs[11],
            lhs[3] * rhs[8]  + lhs[7] * rhs[9]  + lhs[11] * rhs[10] + lhs[15] * rhs[11]
        ),
        Vec4f(
            lhs[0] * rhs[12] + lhs[4] * rhs[13] + lhs[8] * rhs[14]  + lhs[12] * rhs[15],
            lhs[1] * rhs[12] + lhs[5] * rhs[13] + lhs[9] * rhs[14]  + lhs[13] * rhs[15],
            lhs[2] * rhs[12] + lhs[6] * rhs[13] + lhs[10] * rhs[14] + lhs[14] * rhs[15],
            lhs[3] * rhs[12] + lhs[7] * rhs[13] + lhs[11] * rhs[14] + lhs[15] * rhs[15]
        )
    )
    #endif
}

@inlinable
public func multiply(_ lhs: Float, _ rhs: Mat4x4f) -> Mat4x4f {
    #if FRB_MATH_USE_SIMD
    return Mat4x4f(storage: simd_mul(lhs, rhs.storage))
    #else
    return Mat4x4f(rhs.storage.column0 * lhs,
                   rhs.storage.column1 * lhs,
                   rhs.storage.column2 * lhs,
                   rhs.storage.column3 * lhs)
    #endif
}

@inlinable
public func multiply(_ lhs: Vec4f, _ rhs: Mat4x4f) -> Vec4f {
    #if FRB_MATH_USE_SIMD
    return simd_mul(lhs, rhs.storage)
    #else
    #warning("implementation missing")
    return Vec4f.zero
    #endif
}

@inlinable
public func multiply(_ lhs: Mat4x4f, _ rhs: Vec4f) -> Vec4f {
    #if FRB_MATH_USE_SIMD
    return simd_mul(lhs.storage, rhs)
    #else
    #warning("implementation missing")
    return Vec4f.zero
    #endif
}
