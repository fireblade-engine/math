//
//  cross.swift
//  FirebladeMath
//
//  Created by Christian Treffs on 26.08.19.
//

#if canImport(simd)
import func simd.simd_cross
#endif

@inlinable public func cross(_ x: SIMD2<Double>, _ y: SIMD2<Double>) -> SIMD3<Double> {
    #if USE_SIMD
    return simd.simd_cross(x, y)
    #else
    fatalError("implementation missing \(#function) \(#file):\(#line)")
    #endif
}

@inlinable public func cross(_ x: SIMD2<Float>, _ y: SIMD2<Float>) -> SIMD3<Float> {
    #if USE_SIMD
    return simd.simd_cross(x, y)
    #else
    fatalError("implementation missing \(#function) \(#file):\(#line)")
    #endif
}

@inlinable public func cross(_ x: SIMD3<Double>, _ y: SIMD3<Double>) -> SIMD3<Double> {
    #if USE_SIMD
    return simd.simd_cross(x, y)
    #else
    return SIMD3<Double>(x.y * y.z - x.z * y.y,
                         x.z * y.x - x.x * y.z,
                         x.x * y.y - x.y * y.x)
    #endif
}

@inlinable public func cross(_ x: SIMD3<Float>, _ y: SIMD3<Float>) -> SIMD3<Float> {
    #if USE_SIMD
    return simd.simd_cross(x, y)
    #else
    return SIMD3<Float>(x.y * y.z - x.z * y.y,
                        x.z * y.x - x.x * y.z,
                        x.x * y.y - x.y * y.x)
    #endif
}
