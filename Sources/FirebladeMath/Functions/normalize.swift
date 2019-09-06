//
//  normalize.swift
//  FirebladeMath
//
//  Created by Christian Treffs on 26.08.19.
//

#if canImport(simd)
import func simd.simd_normalize
#endif

#if canImport(simd)
@inlinable public func normalize(_ x: SIMD2<Double>) -> SIMD2<Double> {
    return simd_normalize(x)
}

@inlinable public func normalize(_ x: SIMD2<Float>) -> SIMD2<Float> {
    return simd_normalize(x)
}
@inlinable public func normalize(_ x: SIMD3<Double>) -> SIMD3<Double> {
    return simd_normalize(x)
}

@inlinable public func normalize(_ x: SIMD3<Float>) -> SIMD3<Float> {
    return simd_normalize(x)
}

@inlinable public func normalize(_ x: SIMD4<Double>) -> SIMD4<Double> {
    return simd_normalize(x)
}
@inlinable public func normalize(_ x: SIMD4<Float>) -> SIMD4<Float> {
    return simd_normalize(x)
}
#endif

/*
 @inlinable public func normalize<S>(_ x: SIMD2<S>) -> SIMD2<S> where S: FloatingPointScalar {
 return SGLMath.normalize(Vector2<S>(x)).simd
 }

 @inlinable public func normalize<S>(_ x: SIMD3<S>) -> SIMD3<S> where S: FloatingPointScalar {
 return SGLMath.normalize(Vector3<S>(x)).simd
 }

 @inlinable public func normalize<S>(_ x: SIMD4<S>) -> SIMD4<S> where S: FloatingPointScalar {
 return SGLMath.normalize(Vector4<S>(x)).simd
 }
 */
