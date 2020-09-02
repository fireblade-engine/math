//
//  fract.swift
//  FirebladeMath
//
//  Created by Christian Treffs on 26.08.19.
//

#if FRB_USE_SIMD
import func simd.simd_fract
#endif

/// The "fractional part" of x, lying in the range [0, 1).
/// floor(x) + fract(x) is *approximately* equal to x.
/// If x is positive and finite, then the two values are exactly equal.
///
/// - Parameters:
///     - v: floating point value
/// - Returns: The "fractional part" of x
public func fract(_ value: Double) -> Double {
    #if FRB_USE_SIMD
    return simd_fract(value)
    #else
    return min(value - floor(value), Double(0x1.fffffffffffffp-1))
    #endif
}

/// The "fractional part" of x, lying in the range [0, 1).
/// floor(x) + fract(x) is *approximately* equal to x.
/// If x is positive and finite, then the two values are exactly equal.
///
/// - Parameters:
///     - v: floating point value
/// - Returns: The "fractional part" of x
public func fract(_ value: Float) -> Float {
    #if FRB_USE_SIMD
    return simd_fract(value)
    #else
    return min(value - floor(value), Float(0x1.fffffep-1))
    #endif
}
