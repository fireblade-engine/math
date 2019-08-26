//
//  sign.swift
//  FirebladeMath
//
//  Created by Christian Treffs on 26.08.19.
//

#if canImport(simd)
import simd
#endif

#if canImport(SGLMath)
// types
import struct SGLMath.Vector2
import struct SGLMath.Vector3
import struct SGLMath.Vector4
import protocol SGLMath.ArithmeticType

import func SGLMath.sign
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
    // FIXME:SGLMath.sign(<#T##x: VectorType##VectorType#>)
    fatalError("not implemented")
}
