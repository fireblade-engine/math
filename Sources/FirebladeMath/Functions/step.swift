//
//  step.swift
//  FirebladeMath
//
//  Created by Christian Treffs on 26.08.19.
//

#if canImport(simd)
import func simd.step
#endif

/// Returns 0.0 if x < edge, and 1.0 otherwise.
public func step(_ x: Double, _ edge: Double) -> Double {
    #if USE_SIMD
    return simd.step(x, edge: edge)
    #else
    fatalError("implementation missing \(#function) \(#file):\(#line)")
    #endif
}
/// Returns 0.0 if x < edge, and 1.0 otherwise.
public func step(_ x: Float, _ edge: Float) -> Float {
    #if USE_SIMD
    return simd.step(x, edge: edge)
    #else
    fatalError("implementation missing \(#function) \(#file):\(#line)")
    #endif
}
