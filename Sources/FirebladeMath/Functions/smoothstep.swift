//
//  smoothstep.swift
//  FirebladeMath
//
//  Created by Christian Treffs on 26.08.19.
//

#if USE_SIMD
import func simd.simd_smoothstep
#endif

/// Interpolates smoothly between 0 at edge0 and 1 at edge1
/// You can use a scalar value for edge0 and edge1 if you want to clamp all lanes at the same points.
public func smoothstep(_ edge0: Double, _ edge1: Double, _ x: Double) -> Double {
    #if USE_SIMD
    return simd.simd_smoothstep(edge0, edge1, x)
    #else
    let t = clamp((x - edge0) / (edge1 - edge0), 0, 1)
    return t * t * (3 - 2 * t)
    #endif
}

/// Interpolates smoothly between 0 at edge0 and 1 at edge1
/// You can use a scalar value for edge0 and edge1 if you want to clamp all lanes at the same points.
public func smoothstep(_ edge0: Float, _ edge1: Float, _ x: Float) -> Float {
    #if USE_SIMD
    return simd.simd_smoothstep(edge0, edge1, x)
    #else
    let t = clamp((x - edge0) / (edge1 - edge0), 0, 1)
    return t * t * (3 - 2 * t)
    #endif
}
