//
//  fract.swift
//  FirebladeMath
//
//  Created by Christian Treffs on 26.08.19.
//

#if canImport(simd)
import func simd.simd_fract
#endif

#if canImport(SGLMath)
// types
import struct SGLMath.Vector2
import struct SGLMath.Vector3
import struct SGLMath.Vector4

import func SGLMath.fract
#endif

#if canImport(simd)
public func fract(_ v: Double) -> Double {
    return simd_fract(v)
}

public func fract(_ v: Float) -> Float {
    return simd_fract(v)
}

#endif

/// The "fractional part" of x, lying in the range [0, 1).
/// floor(x) + fract(x) is *approximately* equal to x.
/// If x is positive and finite, then the two values are exactly equal.
///
/// - Parameters:
///     - v: floating point value
/// - Returns: The "fractional part" of x
public func fract<S>(_ v: S) -> S where S: FloatingPointScalar {
    // FIXME: return SGLMath.fract(v)
    fatalError("not implemented")
}
