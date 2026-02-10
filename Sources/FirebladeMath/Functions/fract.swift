#if FRB_MATH_USE_SIMD
import func simd.simd_fract
#endif

/// The "fractional part" of x, lying in the range [0, 1).
/// floor(x) + fract(x) is *approximately* equal to x.
/// If x is positive and finite, then the two values are exactly equal.
///
/// - Parameters:
///     - v: floating point value
/// - Returns: The "fractional part" of x
public func fract(_ value: Double) -> Double {
    #if FRB_MATH_USE_SIMD
    return simd_fract(value)
    #else
    return min(value - floor(value), Double(0x1.FFFFFFFFFFFFFp-1))
    #endif
}

/// The "fractional part" of x, lying in the range [0, 1).
/// floor(x) + fract(x) is *approximately* equal to x.
/// If x is positive and finite, then the two values are exactly equal.
///
/// - Parameters:
///     - v: floating point value
/// - Returns: The "fractional part" of x
public func fract(_ value: Float) -> Float {
    #if FRB_MATH_USE_SIMD
    return simd_fract(value)
    #else
    return min(value - floor(value), Float(0x1.FFFFFEp-1))
    #endif
}
