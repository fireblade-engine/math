//
//  length.swift
//  FirebladeMath
//
//  Created by Christian Treffs on 26.08.19.
//

#if canImport(simd)
import func simd.simd_length
import struct simd.simd_quatf
import struct simd.simd_quatd
#endif

#if canImport(SGLMath)
import struct SGLMath.Vector2
import struct SGLMath.Vector3
import struct SGLMath.Vector4

import func SGLMath.length
#endif

#if canImport(simd)
@inlinable public func length(_ x: SIMD2<Double>) -> Double {
    return simd_length(x)
}
@inlinable public func length(_ x: SIMD2<Float>) -> Float {
    return simd_length(x)
}
@inlinable public func length(_ x: SIMD3<Double>) -> Double {
    return simd_length(x)
}
@inlinable public func length(_ x: SIMD3<Float>) -> Float {
    return simd_length(x)
}
@inlinable public func length(_ x: SIMD4<Double>) -> Double {
    return simd_length(x)
}
@inlinable public func length(_ x: SIMD4<Float>) -> Float {
    return simd_length(x)
}
@inlinable public func length(_ x: simd_quatf) -> Float {
    return simd_length(x)
}
@inlinable public func length(_ x: simd_quatd) -> Double {
    return simd_length(x)
}
#endif

/// Computes the length of the argument.
/// For scalar components `length(x)` is equivalent to `abs(x)`.
/// - Parameter float: a float argument
/// - Returns: the distance between the argument and the origin.
@inlinable public func length<S>(_ x: SIMD2<S>) -> S where S: FloatingPointScalar {
    return SGLMath.length(Vector2<S>(x))
}

@inlinable public func length<S>(_ x: SIMD3<S>) -> S where S: FloatingPointScalar {
    return SGLMath.length(Vector3<S>(x))
}

@inlinable public func length<S>(_ x: SIMD4<S>) -> S where S: FloatingPointScalar {
    return SGLMath.length(Vector4<S>(x))
}
