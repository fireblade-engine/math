//
//  sign.swift
//  FirebladeMath
//
//  Created by Christian Treffs on 26.08.19.
//

#if canImport(simd)
import func simd.simd_sign
#endif

/// Returns -1 if `x < 0`, +1 if `x > 0`, and 0 otherwise (`sign(NaN)` is 0).
public func sign(_ x: Double) -> Double {
    #if USE_SIMD
    return simd_sign(x)
    #else
    fatalError("implementation missing \(#function) \(#file):\(#line)")
    #endif
}

/// Returns -1 if `x < 0`, +1 if `x > 0`, and 0 otherwise (`sign(NaN)` is 0).
public func sign(_ x: Float) -> Float {
    #if USE_SIMD
    return simd_sign(x)
    #else
    fatalError("implementation missing \(#function) \(#file):\(#line)")
    #endif
}
