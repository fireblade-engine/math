//
//  clamp.swift
//  FirebladeMath
//
//  Created by Christian Treffs on 26.08.19.
//

#if canImport(simd)
import func simd.simd_clamp
#endif

#if canImport(simd)
public func clamp(_ x: Double, _ min: Double, _ max: Double) -> Double {
    return simd_clamp(x, min, max)
}
public func clamp(_ x: Float, _ min: Float, _ max: Float) -> Float {
    return simd_clamp(x, min, max)
}
#endif

/// x clamped to the range [min, max].
/// Note that if you want to clamp all lanes to the same range, you can use a scalar value for min and max.
/// - Parameters:
///   - x: value to be clamped
///   - min: min range bound
///   - max: max range bound
/// - Returns: x clamped to the range [min, max]
public func clamp<S>(_ x: S, _ minVal: S, _ maxVal: S) -> S where S: Scalar {
    return min(max(x, minVal), maxVal)
}
