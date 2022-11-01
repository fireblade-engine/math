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
            lhs[0] * rhs[0] + lhs[4] * rhs[1] + lhs[8] * rhs[2] + lhs[12] * rhs[3],
            lhs[1] * rhs[0] + lhs[5] * rhs[1] + lhs[9] * rhs[2] + lhs[13] * rhs[3],
            lhs[2] * rhs[0] + lhs[6] * rhs[1] + lhs[10] * rhs[2] + lhs[14] * rhs[3],
            lhs[3] * rhs[0] + lhs[7] * rhs[1] + lhs[11] * rhs[2] + lhs[15] * rhs[3]
        ),
        Vec4d(
            lhs[0] * rhs[4] + lhs[4] * rhs[5] + lhs[8] * rhs[6] + lhs[12] * rhs[7],
            lhs[1] * rhs[4] + lhs[5] * rhs[5] + lhs[9] * rhs[6] + lhs[13] * rhs[7],
            lhs[2] * rhs[4] + lhs[6] * rhs[5] + lhs[10] * rhs[6] + lhs[14] * rhs[7],
            lhs[3] * rhs[4] + lhs[7] * rhs[5] + lhs[11] * rhs[6] + lhs[15] * rhs[7]
        ),
        Vec4d(
            lhs[0] * rhs[8] + lhs[4] * rhs[9] + lhs[8] * rhs[10] + lhs[12] * rhs[11],
            lhs[1] * rhs[8] + lhs[5] * rhs[9] + lhs[9] * rhs[10] + lhs[13] * rhs[11],
            lhs[2] * rhs[8] + lhs[6] * rhs[9] + lhs[10] * rhs[10] + lhs[14] * rhs[11],
            lhs[3] * rhs[8] + lhs[7] * rhs[9] + lhs[11] * rhs[10] + lhs[15] * rhs[11]
        ),
        Vec4d(
            lhs[0] * rhs[12] + lhs[4] * rhs[13] + lhs[8] * rhs[14] + lhs[12] * rhs[15],
            lhs[1] * rhs[12] + lhs[5] * rhs[13] + lhs[9] * rhs[14] + lhs[13] * rhs[15],
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
    return Mat4x4d(lhs * rhs.storage.columns.0,
                   lhs * rhs.storage.columns.1,
                   lhs * rhs.storage.columns.2,
                   lhs * rhs.storage.columns.3)
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
    let Q = lhs[0, 0] * rhs[0] + lhs[1, 0] * rhs[1] + lhs[2, 0] * rhs[2] + lhs[3, 0] * rhs[3]
    let R = lhs[0, 1] * rhs[0] + lhs[1, 1] * rhs[1] + lhs[2, 1] * rhs[2] + lhs[3, 1] * rhs[3]
    let S = lhs[0, 2] * rhs[0] + lhs[1, 2] * rhs[1] + lhs[2, 2] * rhs[2] + lhs[3, 2] * rhs[3]
    let T = lhs[0, 3] * rhs[0] + lhs[1, 3] * rhs[1] + lhs[2, 3] * rhs[2] + lhs[3, 3] * rhs[3]
    return SIMD4<Double>(Q, R, S, T)
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
            lhs[0] * rhs[0] + lhs[4] * rhs[1] + lhs[8] * rhs[2] + lhs[12] * rhs[3],
            lhs[1] * rhs[0] + lhs[5] * rhs[1] + lhs[9] * rhs[2] + lhs[13] * rhs[3],
            lhs[2] * rhs[0] + lhs[6] * rhs[1] + lhs[10] * rhs[2] + lhs[14] * rhs[3],
            lhs[3] * rhs[0] + lhs[7] * rhs[1] + lhs[11] * rhs[2] + lhs[15] * rhs[3]
        ),
        Vec4f(
            lhs[0] * rhs[4] + lhs[4] * rhs[5] + lhs[8] * rhs[6] + lhs[12] * rhs[7],
            lhs[1] * rhs[4] + lhs[5] * rhs[5] + lhs[9] * rhs[6] + lhs[13] * rhs[7],
            lhs[2] * rhs[4] + lhs[6] * rhs[5] + lhs[10] * rhs[6] + lhs[14] * rhs[7],
            lhs[3] * rhs[4] + lhs[7] * rhs[5] + lhs[11] * rhs[6] + lhs[15] * rhs[7]
        ),
        Vec4f(
            lhs[0] * rhs[8] + lhs[4] * rhs[9] + lhs[8] * rhs[10] + lhs[12] * rhs[11],
            lhs[1] * rhs[8] + lhs[5] * rhs[9] + lhs[9] * rhs[10] + lhs[13] * rhs[11],
            lhs[2] * rhs[8] + lhs[6] * rhs[9] + lhs[10] * rhs[10] + lhs[14] * rhs[11],
            lhs[3] * rhs[8] + lhs[7] * rhs[9] + lhs[11] * rhs[10] + lhs[15] * rhs[11]
        ),
        Vec4f(
            lhs[0] * rhs[12] + lhs[4] * rhs[13] + lhs[8] * rhs[14] + lhs[12] * rhs[15],
            lhs[1] * rhs[12] + lhs[5] * rhs[13] + lhs[9] * rhs[14] + lhs[13] * rhs[15],
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
    return Mat4x4f(lhs * rhs.storage.column0,
                   lhs * rhs.storage.column1,
                   lhs * rhs.storage.column2,
                   lhs * rhs.storage.column3)
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
    let Q = lhs[0, 0] * rhs[0] + lhs[1, 0] * rhs[1] + lhs[2, 0] * rhs[2] + lhs[3, 0] * rhs[3]
    let R = lhs[0, 1] * rhs[0] + lhs[1, 1] * rhs[1] + lhs[2, 1] * rhs[2] + lhs[3, 1] * rhs[3]
    let S = lhs[0, 2] * rhs[0] + lhs[1, 2] * rhs[1] + lhs[2, 2] * rhs[2] + lhs[3, 2] * rhs[3]
    let T = lhs[0, 3] * rhs[0] + lhs[1, 3] * rhs[1] + lhs[2, 3] * rhs[2] + lhs[3, 3] * rhs[3]
    return SIMD4<Float>(Q, R, S, T)
    #endif
}

// MARK: - Mat2x2d
@inlinable
public func multiply(_ lhs: Mat2x2d, _ rhs: Mat2x2d) -> Mat2x2d {
    #if FRB_MATH_USE_SIMD
    return Mat2x2d(storage: simd_mul(lhs.storage, rhs.storage))
    #else
    return Mat2x2d(
        Vec2d(
            lhs[0, 0] * rhs[0, 0] + lhs[1, 0] * rhs[0, 1],
            lhs[0, 1] * rhs[0, 0] + lhs[1, 1] * rhs[0, 1]
        ),
        Vec2d(
            lhs[0, 0] * rhs[1, 0] + lhs[1, 0] * rhs[1, 1],
            lhs[0, 1] * rhs[1, 0] + lhs[1, 1] * rhs[1, 1]
        )
    )
    #endif
}

@inlinable
public func multiply(_ lhs: Double, _ rhs: Mat2x2d) -> Mat2x2d {
    #if FRB_MATH_USE_SIMD
    return Mat2x2d(storage: simd_mul(lhs, rhs.storage))
    #else
    return Mat2x2d(lhs * rhs.storage.columns.0,
                   lhs * rhs.storage.columns.1)
    #endif
}

@inlinable
public func multiply(_ lhs: Vec2d, _ rhs: Mat2x2d) -> Vec2d {
    #if FRB_MATH_USE_SIMD
    return simd_mul(lhs, rhs.storage)
    #else
    #warning("implementation missing")
    return Vec2d.zero
    #endif
}

@inlinable
public func multiply(_ lhs: Mat2x2d, _ rhs: Vec2d) -> Vec2d {
    #if FRB_MATH_USE_SIMD
    return simd_mul(lhs.storage, rhs)
    #else
    let Q = lhs[0, 0] * rhs[0] + lhs[1, 0] * rhs[1]
    let R = lhs[0, 1] * rhs[0] + lhs[1, 1] * rhs[1]
    return SIMD2<Double>(Q, R)
    #endif
}

// MARK: - Mat4x4f
@inlinable
public func multiply(_ lhs: Mat2x2f, _ rhs: Mat2x2f) -> Mat2x2f {
    #if FRB_MATH_USE_SIMD
    return Mat2x2f(storage: simd_mul(lhs.storage, rhs.storage))
    #else
    return Mat2x2f(
        Vec2f(
            lhs[0, 0] * rhs[0, 0] + lhs[1, 0] * rhs[0, 1],
            lhs[0, 1] * rhs[0, 0] + lhs[1, 1] * rhs[0, 1]
        ),
        Vec2f(
            lhs[0, 0] * rhs[1, 0] + lhs[1, 0] * rhs[1, 1],
            lhs[0, 1] * rhs[1, 0] + lhs[1, 1] * rhs[1, 1]
        )
    )
    #endif
}

@inlinable
public func multiply(_ lhs: Float, _ rhs: Mat2x2f) -> Mat2x2f {
    #if FRB_MATH_USE_SIMD
    return Mat2x2f(storage: simd_mul(lhs, rhs.storage))
    #else
    return Mat2x2f(lhs * rhs.storage.column0,
                   lhs * rhs.storage.column1,
                   lhs * rhs.storage.column2,
                   lhs * rhs.storage.column3)
    #endif
}

@inlinable
public func multiply(_ lhs: Vec2f, _ rhs: Mat2x2f) -> Vec2f {
    #if FRB_MATH_USE_SIMD
    return simd_mul(lhs, rhs.storage)
    #else
    #warning("implementation missing")
    return Vec2f.zero
    #endif
}

@inlinable
public func multiply(_ lhs: Mat2x2f, _ rhs: Vec2f) -> Vec2f {
    #if FRB_MATH_USE_SIMD
    return simd_mul(lhs.storage, rhs)
    #else
    let Q = lhs[0, 0] * rhs[0] + lhs[1, 0] * rhs[1]
    let R = lhs[0, 1] * rhs[0] + lhs[1, 1] * rhs[1]
    return SIMD2<Float>(Q, R)
    #endif
}
