//
//  smoothstep.swift
//  FirebladeMath
//
//  Created by Christian Treffs on 26.08.19.
//

#if canImport(simd)
import func simd.simd_smoothstep
#endif

#if canImport(SGLMath)
import struct SGLMath.Vector2
import struct SGLMath.Vector3
import struct SGLMath.Vector4
import func SGLMath.smoothstep
#endif

#if canImport(simd)

public func smoothstep(_ edge0: Double, _ edge1: Double, _ x: Double) -> Double {
    return simd.simd_smoothstep(edge0, edge1, x)
}

public func smoothstep(_ edge0: Float, _ edge1: Float, _ x: Float) -> Float {
    return simd.simd_smoothstep(edge0, edge1, x)
}

// FIXME: all vector types
#endif

/// Interpolates smoothly between 0 at edge0 and 1 at edge1
/// You can use a scalar value for edge0 and edge1 if you want to clamp all lanes at the same points.
public func smoothstep<S>(_ edge0: S, _ edge1: S, _ x: S) -> S where S: Scalar {
    // FIXME: return SGLMath.smoothstep(edge0, edge1, x)
    fatalError("not implemented yet.")
}
