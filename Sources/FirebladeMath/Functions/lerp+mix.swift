#if FRB_MATH_USE_SIMD
import func simd.simd_mix
#endif

/// Performs a linear interpolation between v0 and v1 by the interpolant t.
/// - Parameters:
///   - v0: The start value.
///   - v1: The end value.
///   - t: The interpolant.
/// - Returns: The interpolated value.
public func interpolate<Value: FloatingPoint>(_ v0: Value, _ v1: Value, _ t: Value) -> Value {
    lerp(v0, v1, t)
}

/// Performs a linear interpolation between v0 and v1 by the interpolant t
///
/// Precise method, which guarantees v = v1 when t = 1.
/// - parameter v0: start value
/// - parameter v1: end value
/// - parameter t: interpolant
///
/// - returns: v0 value interpolated from v0 to v1
public func lerpPrecise<Value: FloatingPoint>(_ v0: Value, _ v1: Value, _ t: Value) -> Value {
    (1 - t) * v0 + t * v1
}

/// Performs a linear interpolation between v0 and v1 by the interpolant t.
/// - Parameters:
///   - v0: The start value.
///   - v1: The end value.
///   - t: The interpolant.
/// - Returns: The interpolated value.
public func lerp<Value: FloatingPoint>(_ v0: Value, _ v1: Value, _ t: Value) -> Value {
    v0 + t * (v1 - v0)
}

/// Linearly interpolates between x and y, taking the value x when t=0 and y when t=1
/// - Parameters:
///   - v0: The start value.
///   - v1: The end value.
///   - t: The interpolant.
/// - Returns: The interpolated value.
public func mix(_ v0: Double, _ v1: Double, _ t: Double) -> Double {
    #if FRB_MATH_USE_SIMD
    return simd_mix(v0, v1, t)
    #else
    return lerp(v0, v1, t)
    #endif
}

/// Linearly interpolates between x and y, taking the value x when t=0 and y when t=1
/// - Parameters:
///   - v0: The start value.
///   - v1: The end value.
///   - t: The interpolant.
/// - Returns: The interpolated value.
public func mix(_ v0: Float, _ v1: Float, _ t: Float) -> Float {
    #if FRB_MATH_USE_SIMD
    return simd_mix(v0, v1, t)
    #else
    return lerp(v0, v1, t)
    #endif
}

extension FloatingPoint {
    /// Linearly interpolates this value from one range to another.
    /// - Parameters:
    ///   - rangeIn: The input range.
    ///   - rangeOut: The output range.
    /// - Returns: The interpolated value.
    @inlinable
    public func lerped(from rangeIn: ClosedRange<Self>, to rangeOut: ClosedRange<Self>) -> Self {
        let x: Self = self
        let x0: Self = rangeIn.lowerBound
        let x1: Self = rangeIn.upperBound
        let y0: Self = rangeOut.lowerBound
        let y1: Self = rangeOut.upperBound
        let frac: Self = (y1 - y0) / (x1 - x0)
        return y0 + (x - x0) * frac
    }

    /// Linearly interpolates this value from one range to another in place.
    /// - Parameters:
    ///   - rangeIn: The input range.
    ///   - rangeOut: The output range.
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