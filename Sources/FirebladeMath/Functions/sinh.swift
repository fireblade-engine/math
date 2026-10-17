import FirebladeMathLibC

/// Computes hyperbolic sine of x.
///
/// - Parameter x:     floating point value representing a hyperbolic angle
/// - Returns: If no errors occur, the hyperbolic sine of x (sinh(x), or (e^x*-e-x)/2) is returned.
/// If a range error due to overflow occurs, ±HUGE_VAL, ±HUGE_VALF, or ±HUGE_VALL is returned.
/// If a range error occurs due to underflow, the correct result (after rounding) is returned.
@_disfavoredOverload
public func sinh(_ x: Float) -> Float {
    FirebladeMathLibC.sinhf(x)
}

/// Computes hyperbolic sine of x.
///
/// - Parameter x:     floating point value representing a hyperbolic angle
/// - Returns: If no errors occur, the hyperbolic sine of x (sinh(x), or (e^x*-e-x)/2) is returned.
/// If a range error due to overflow occurs, ±HUGE_VAL, ±HUGE_VALF, or ±HUGE_VALL is returned.
/// If a range error occurs due to underflow, the correct result (after rounding) is returned.
@_disfavoredOverload
public func sinh(_ x: Double) -> Double {
    FirebladeMathLibC.sinh(x)
}
