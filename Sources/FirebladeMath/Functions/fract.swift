//
//  fract.swift
//  FirebladeMath
//
//  Created by Christian Treffs on 26.08.19.
//

#if canImport(simd)
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
    #if USE_SIMD
    return simd_fract(value)
    #else
    fatalError("implementation missing \(#function) \(#file):\(#line)")
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
    #if USE_SIMD
    return simd_fract(value)
    #else
    fatalError("implementation missing \(#function) \(#file):\(#line)")
    #endif
}
