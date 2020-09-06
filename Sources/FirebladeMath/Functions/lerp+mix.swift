//
//  lerp.swift
//  FirebladeMath
//
//  Created by Christian Treffs on 10.09.19.
//

#if FRB_MATH_USE_SIMD
import func simd.simd_mix
#endif

public func interpolate<Value>(_ v0: Value, _ v1: Value, _ t: Value) -> Value where Value: FloatingPoint {
    lerp(v0, v1, t)
}

/// Performs a linear interpolation between a and b by the interpolant t
///
/// Precise method, which guarantees v = v1 when t = 1.
/// - parameter v0: start value
/// - parameter v1: end value
/// - parameter t: interpolant
///
/// - returns: v0 value interpolated from v0 to v1
public func lerpPrecise<Value>(_ v0: Value, _ v1: Value, _ t: Value) -> Value where Value: FloatingPoint {
    (1 - t) * v0 + t * v1
}

public func lerp<Value>(_ v0: Value, _ v1: Value, _ t: Value) -> Value where Value: FloatingPoint {
    v0 + t * (v1 - v0)
}

/// Linearly interpolates between x and y, taking the value x when t=0 and y when t=1
public func mix(_ v0: Double, _ v1: Double, _ t: Double) -> Double {
    #if FRB_MATH_USE_SIMD
    return simd_mix(v0, v1, t)
    #else
    return lerp(v0, v1, t)
    #endif
}

/// Linearly interpolates between x and y, taking the value x when t=0 and y when t=1
public func mix(_ v0: Float, _ v1: Float, _ t: Float) -> Float {
    #if FRB_MATH_USE_SIMD
    return simd_mix(v0, v1, t)
    #else
    return lerp(v0, v1, t)
    #endif
}

extension FloatingPoint {
    @inlinable
    public func lerped(from rangeIn: ClosedRange<Self>, to rangeOut: ClosedRange<Self>) -> Self {
        let x: Self = self
        let x0: Self = rangeIn.lowerBound
        let x1: Self = rangeIn.upperBound
        let y0: Self = rangeOut.lowerBound
        let y1: Self = rangeOut.upperBound
        let frac: Self = (y1 - y0) / (x1 - x0)
        let y: Self = y0 + (x - x0) * frac
        return y
    }

    @inlinable
    public mutating func lerp(from rangeIn: ClosedRange<Self>, to rangeOut: ClosedRange<Self>) {
        let x: Self = self
        let x0: Self = rangeIn.lowerBound
        let x1: Self = rangeIn.upperBound
        let y0: Self = rangeOut.lowerBound
        let y1: Self = rangeOut.upperBound
        let frac: Self = (y1 - y0) / (x1 - x0)
        self = y0 + (x - x0) * frac
    }
}
