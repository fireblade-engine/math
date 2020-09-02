//
//  normalize.swift
//  FirebladeMath
//
//  Created by Christian Treffs on 26.08.19.
//

#if FRB_USE_SIMD
import func simd.simd_normalize
#endif

@inlinable public func normalize(_ x: SIMD2<Double>) -> SIMD2<Double> {
    #if FRB_USE_SIMD
    return simd_normalize(x)
    #else
    let scale: Double = 1.0 / length(x)
    return SIMD2<Double>(x.x * scale, x.y * scale)
    #endif
}

@inlinable public func normalize(_ x: SIMD2<Float>) -> SIMD2<Float> {
    #if FRB_USE_SIMD
    return simd_normalize(x)
    #else
    let scale: Float = 1.0 / length(x)
    return SIMD2<Float>(x.x * scale, x.y * scale)
    #endif
}

@inlinable public func normalize(_ x: SIMD3<Double>) -> SIMD3<Double> {
    #if FRB_USE_SIMD
    return simd_normalize(x)
    #else
    let scale: Double = 1.0 / length(x)
    return SIMD3<Double>(x.x * scale, x.y * scale, x.z * scale)
    #endif
}

@inlinable public func normalize(_ x: SIMD3<Float>) -> SIMD3<Float> {
    #if FRB_USE_SIMD
    return simd_normalize(x)
    #else
    let scale: Float = 1.0 / length(x)
    return SIMD3<Float>(x.x * scale, x.y * scale, x.z * scale)
    #endif
}

@inlinable public func normalize(_ x: SIMD4<Double>) -> SIMD4<Double> {
    #if FRB_USE_SIMD
    return simd_normalize(x)
    #else
    let scale: Double = 1.0 / length(x)
    return SIMD4<Double>(x.x * scale, x.y * scale, x.z * scale, x.w * scale)
    #endif
}

@inlinable public func normalize(_ x: SIMD4<Float>) -> SIMD4<Float> {
    #if FRB_USE_SIMD
    return simd_normalize(x)
    #else
    let scale: Float = 1.0 / length(x)
    return SIMD4<Float>(x.x * scale, x.y * scale, x.z * scale, x.w * scale)
    #endif
}

@inlinable public func normalize(_ x: Quat4f) -> Quat4f {
    #if FRB_USE_SIMD
    return Quat4f(storage: simd.simd_normalize(x.storage))
    #else
    let scale: Float = 1.0 / length(x)
    return Quat4f(x.x * scale, x.y * scale, x.z * scale, x.w * scale)
    #endif
}

@inlinable public func normalize(_ x: Quat4d) -> Quat4d {
    #if FRB_USE_SIMD
    return Quat4d(storage: simd.simd_normalize(x.storage))
    #else
    let scale: Double = 1.0 / length(x)
    return Quat4d(x.x * scale, x.y * scale, x.z * scale, x.w * scale)
    #endif
}
