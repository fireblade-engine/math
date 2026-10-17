import FirebladeMathLibC

/// Computes the hyperbolic cosine of x.
///
/// - Parameter x: floating point value representing a hyperbolic angle
/// - Returns: If no errors occur, the hyperbolic cosine of x (cosh(x), or (e^x+e^-x)/2) is returned.
/// If a range error due to overflow occurs, +HUGE_VAL, +HUGE_VALF, or +HUGE_VALL is returned.
@_disfavoredOverload
@inlinable
@inline(__always)
public func cosh(_ x: Float) -> Float {
    FirebladeMathLibC.coshf(x)
}

/// Computes the hyperbolic cosine of x.
///
/// - Parameter x: floating point value representing a hyperbolic angle
/// - Returns: If no errors occur, the hyperbolic cosine of x (cosh(x), or (e^x+e^-x)/2) is returned.
/// If a range error due to overflow occurs, +HUGE_VAL, +HUGE_VALF, or +HUGE_VALL is returned.
@_disfavoredOverload
@inlinable
@inline(__always)
public func cosh(_ x: Double) -> Double {
    FirebladeMathLibC.cosh(x)
}
