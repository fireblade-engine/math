//
//  sign.swift
//  FirebladeMath
//
//  Created by Christian Treffs on 26.08.19.
//

#if canImport(simd)
import simd
#endif

#if canImport(simd)
public func sign(_ x: Double) -> Double {
    return simd_sign(x)
}
public func sign(_ x: Float) -> Float {
    return simd_sign(x)
}
// TODO: vector signs
#endif

/// Returns -1 if `x < 0`, +1 if `x > 0`, and 0 otherwise (`sign(NaN)` is 0).
public func sign<S>(_ x: S) -> S where S: FloatingPointScalar {
    return x == 0 ? 0 : x < 0 ? -1 : 1
}
