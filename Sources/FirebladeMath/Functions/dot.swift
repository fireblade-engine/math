//
//  dot.swift
//  FirebladeMath
//
//  Created by Christian Treffs on 26.08.19.
//

#if canImport(simd)
import func simd.simd_dot
#endif

import GLKit

@inlinable public func dot(_ x: SIMD2<Double>, _ y: SIMD2<Double>) -> Double {
    #if USE_SIMD
    return simd_dot(x, y)
    #else
    fatalError("implementation missing \(#function) \(#file):\(#line)")
    #endif
}
@inlinable public func dot(_ x: SIMD2<Float>, _ y: SIMD2<Float>) -> Float {
    #if USE_SIMD
    return simd_dot(x, y)
    #else
    fatalError("implementation missing \(#function) \(#file):\(#line)")
    #endif
}
@inlinable public func dot(_ x: SIMD3<Double>, _ y: SIMD3<Double>) -> Double {
    #if USE_SIMD
    return simd_dot(x, y)
    #else
    return x.x * y.x + x.y * y.y + x.z * y.z
    #endif
}
@inlinable public func dot(_ x: SIMD3<Float>, _ y: SIMD3<Float>) -> Float {
    #if USE_SIMD
    return simd_dot(x, y)
    #else
    return x.x * y.x + x.y * y.y + x.z * y.z
    #endif
}
@inlinable public func dot(_ x: SIMD4<Double>, _ y: SIMD4<Double>) -> Double {
    #if USE_SIMD
    return simd_dot(x, y)
    #else
    fatalError("implementation missing \(#function) \(#file):\(#line)")
    #endif
}
@inlinable public func dot(_ x: SIMD4<Float>, _ y: SIMD4<Float>) -> Float {
    #if USE_SIMD
    return simd_dot(x, y)
    #else
    fatalError("implementation missing \(#function) \(#file):\(#line)")
    #endif
}
