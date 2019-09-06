//
//  normalize.swift
//  FirebladeMath
//
//  Created by Christian Treffs on 26.08.19.
//

#if canImport(simd)
import func simd.simd_normalize
#endif

@inlinable public func normalize(_ x: SIMD2<Double>) -> SIMD2<Double> {
    #if USE_SIMD
    return simd_normalize(x)
    #else
    fatalError("implementation missing \(#function) \(#file):\(#line)")
    #endif
}

@inlinable public func normalize(_ x: SIMD2<Float>) -> SIMD2<Float> {
    #if USE_SIMD
    return simd_normalize(x)
    #else
    fatalError("implementation missing \(#function) \(#file):\(#line)")
    #endif
}

@inlinable public func normalize(_ x: SIMD3<Double>) -> SIMD3<Double> {
    #if USE_SIMD
    return simd_normalize(x)
    #else
    fatalError("implementation missing \(#function) \(#file):\(#line)")
    #endif
}

@inlinable public func normalize(_ x: SIMD3<Float>) -> SIMD3<Float> {
    #if USE_SIMD
    return simd_normalize(x)
    #else
    fatalError("implementation missing \(#function) \(#file):\(#line)")
    #endif
}

@inlinable public func normalize(_ x: SIMD4<Double>) -> SIMD4<Double> {
    #if USE_SIMD
    return simd_normalize(x)
    #else
    fatalError("implementation missing \(#function) \(#file):\(#line)")
    #endif
}

@inlinable public func normalize(_ x: SIMD4<Float>) -> SIMD4<Float> {
    #if USE_SIMD
    return simd_normalize(x)
    #else
    fatalError("implementation missing \(#function) \(#file):\(#line)")
    #endif
}

@inlinable public func normalize(_ x: Quat4f) -> Quat4f {
    #if USE_SIMD
    return Quat4f(storage: simd.simd_normalize(x.storage))
    #else
    fatalError("implementation missing \(#function) \(#file):\(#line)")
    #endif
}

@inlinable public func normalize(_ x: Quat4d) -> Quat4d {
    #if USE_SIMD
    return Quat4d(storage: simd.simd_normalize(x.storage))
    #else
    fatalError("implementation missing \(#function) \(#file):\(#line)")
    #endif
}

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
