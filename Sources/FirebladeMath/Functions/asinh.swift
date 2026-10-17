import FirebladeMathLibC

/// Computes the inverse hyperbolic sine of x.
///
/// - Parameter x: floating point value representing the area of a hyperbolic sector
/// - Returns: If no errors occur, the inverse hyperbolic sine of x (sinh^-1(x), or arsinh(x)), is returned.
/// If a range error occurs due to underflow, the correct result (after rounding) is returned.
@_disfavoredOverload
@inlinable
@inline(__always)
public func asinh(_ x: Double) -> Double {
    FirebladeMathLibC.asinh(x)
}

/// Computes the inverse hyperbolic sine of x.
///
/// - Parameter x: floating point value representing the area of a hyperbolic sector
/// - Returns: If no errors occur, the inverse hyperbolic sine of x (sinh^-1(x), or arsinh(x)), is returned.
/// If a range error occurs due to underflow, the correct result (after rounding) is returned.
@_disfavoredOverload
@inlinable
@inline(__always)
public func asinh(_ x: Float) -> Float {
    FirebladeMathLibC.asinhf(x)
}
