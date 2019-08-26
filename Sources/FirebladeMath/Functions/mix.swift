//
//  mix.swift
//  FirebladeMath
//
//  Created by Christian Treffs on 26.08.19.
//

#if canImport(simd)
import simd
#endif

#if canImport(SGLMath)
import func SGLMath.mix
#endif

// MARK: - mix
#if canImport(simd)
public func mix(_ x: Double, _ y: Double, _ t: Double) -> Double {
    return simd_mix(x, y, t)
}

public func mix(_ x: Float, _ y: Float, _ t: Float) -> Float {
    return simd_mix(x, y, t)
}
#endif

/// Linearly interpolates between x and y, taking the value x when t=0 and y when t=1
public func mix<S>(_ x: S, _ y: S, _ t: S) -> S where S: Scalar {
    // FIXME: return SGLMath.mix(x, y, t)
    fatalError("not implemented")
}
