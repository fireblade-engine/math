//
//  rsqrt.swift
//  FirebladeMath
//
//  Created by Christian Treffs on 26.08.19.
//

#if canImport(simd)
import func simd.simd_rsqrt
#endif

#if canImport(SGLMath)

import struct SGLMath.Vector2
import struct SGLMath.Vector3
import struct SGLMath.Vector4

// functions
import class SGLMath.SGLMath
#endif

#if canImport(simd)
public func rsqrt(_ x: Double) -> Double {
    return simd.simd_rsqrt(x)
}
public func rsqrt(_ x: Float) -> Float {
    return simd.simd_rsqrt(x)
}
#endif

/// Reciprocal square root.
///
/// - Parameter float: floating point value
/// - Returns: 1 / sqrt(arg)
public func rsqrt<S>(_ x: S) -> S where S: FloatingPointScalar {
    return 1.0 / SGLMath.SGLsqrt(x)
}
