//
//  cross.swift
//  FirebladeMath
//
//  Created by Christian Treffs on 26.08.19.
//

#if canImport(simd)
import func simd.simd_cross
#endif

#if canImport(SGLMath)
// types
import struct SGLMath.Vector2
import struct SGLMath.Vector3
import struct SGLMath.Vector4

import func SGLMath.cross
#endif

#if canImport(simd)
@inlinable public func cross(_ x: SIMD2<Double>, _ y: SIMD2<Double>) -> SIMD3<Double> {
    return simd.simd_cross(x, y)
}
@inlinable public func cross(_ x: SIMD2<Float>, _ y: SIMD2<Float>) -> SIMD3<Float> {
    return simd.simd_cross(x, y)
}
@inlinable public func cross(_ x: SIMD3<Double>, _ y: SIMD3<Double>) -> SIMD3<Double> {
    return simd.simd_cross(x, y)
}
@inlinable public func cross(_ x: SIMD3<Float>, _ y: SIMD3<Float>) -> SIMD3<Float> {
    return simd.simd_cross(x, y)
}
#endif

@inlinable public func cross<S>(_ x: SIMD3<S>, _ y: SIMD3<S>) -> SIMD3<S> where S: FloatingPointScalar {
    return SGLMath.cross(Vector3<S>(x), Vector3<S>(y)).simd
}
