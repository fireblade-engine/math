//
//  step.swift
//  FirebladeMath
//
//  Created by Christian Treffs on 26.08.19.
//

#if canImport(simd)
import func simd.step
#endif

#if canImport(SGLMath)
// types
import struct SGLMath.Vector2
import struct SGLMath.Vector3
import struct SGLMath.Vector4

import func SGLMath.step
#endif

#if canImport(simd)

public func step(_ x: Double, _ edge: Double) -> Double {
    return simd.step(x, edge: edge)
}

public func step(_ x: Float, _ edge: Float) -> Float {
    return simd.step(x, edge: edge)
}

#endif

/// Returns 0.0 if x < edge, and 1.0 otherwise.
public func step<S>(_ x: S, _ edge: S) -> S where S: Scalar {
    // FIXME: return SGLMath.step(edge, x)
    fatalError("not implemented yet.")
}
