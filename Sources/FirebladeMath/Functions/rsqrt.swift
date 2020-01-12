//
//  rsqrt.swift
//  FirebladeMath
//
//  Created by Christian Treffs on 26.08.19.
//

#if canImport(simd)
import func simd.simd_rsqrt
#endif

/// Reciprocal square root.
///
/// - Parameter float: floating point value
/// - Returns: 1 / sqrt(arg)
public func rsqrt(_ x: Double) -> Double {
    #if USE_SIMD
    return simd.simd_rsqrt(x)
    #else
    return 1.0 / sqrt(x)
    #endif
}

/// Reciprocal square root.
///
/// - Parameter float: floating point value
/// - Returns: 1 / sqrt(arg)
public func rsqrt(_ x: Float) -> Float {
    #if USE_SIMD
    return simd.simd_rsqrt(x)
    #else
    return 1.0 / sqrt(x)
    #endif
}
