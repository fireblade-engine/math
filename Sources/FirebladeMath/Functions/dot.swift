//
//  dot.swift
//  FirebladeMath
//
//  Created by Christian Treffs on 26.08.19.
//

#if canImport(simd)
import func simd.simd_dot
#endif

#if canImport(SGLMath)
// types
import struct SGLMath.Vector2
import struct SGLMath.Vector3
import struct SGLMath.Vector4

import func SGLMath.dot
#endif

// MARK: - dot

#if canImport(simd)
@inlinable public func dot(_ x: SIMD2<Double>, _ y: SIMD2<Double>) -> Double {
    return simd_dot(x, y)
}
@inlinable public func dot(_ x: SIMD2<Float>, _ y: SIMD2<Float>) -> Float {
    return simd_dot(x, y)
}
@inlinable public func dot(_ x: SIMD3<Double>, _ y: SIMD3<Double>) -> Double {
    return simd_dot(x, y)
}
@inlinable public func dot(_ x: SIMD3<Float>, _ y: SIMD3<Float>) -> Float {
    return simd_dot(x, y)
}
@inlinable public func dot(_ x: SIMD4<Double>, _ y: SIMD4<Double>) -> Double {
    return simd_dot(x, y)
}
@inlinable public func dot(_ x: SIMD4<Float>, _ y: SIMD4<Float>) -> Float {
    return simd_dot(x, y)
}
#endif

/// Computes the dot product of the arguments.
/// For scalar components `dot(x, y)` is equivalent to `x*y`.
/// - Parameters:
///   - x: a float argument.
///   - y: a float argument.
/// - Returns: the dot product of the arguments.
@inlinable public func dot<S>(_ x: SIMD2<S>, _ y: SIMD2<S>) -> S where S: FloatingPointScalar {
    return SGLMath.dot(Vector2<S>(x), Vector2<S>(y))
}

@inlinable public func dot<S>(_ x: SIMD3<S>, _ y: SIMD3<S>) -> S where S: FloatingPointScalar {
    return SGLMath.dot(Vector3<S>(x), Vector3<S>(y))
}

@inlinable public func dot<S>(_ x: SIMD4<S>, _ y: SIMD4<S>) -> S where S: FloatingPointScalar {
    return SGLMath.dot(Vector4<S>(x), Vector4<S>(y))
}
