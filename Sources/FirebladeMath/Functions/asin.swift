import FirebladeMathLibC

/// Computes the principal values of the arc sine of x.
///
/// - Parameter x: floating point value
/// - Returns: If no errors occur, the arc sine of x (arcsin(x)) in the range [-π/2;+π/2], is returned.
/// If a domain error occurs, an implementation-defined value is returned (NaN where supported).
/// If a range error occurs due to underflow, the correct result (after rounding) is returned.
@_disfavoredOverload
@inlinable
@inline(__always)
public func asin(_ x: Double) -> Double {
    FirebladeMathLibC.asin(x)
}

/// Computes the principal values of the arc sine of x.
///
/// - Parameter x: floating point value
/// - Returns: If no errors occur, the arc sine of x (arcsin(x)) in the range [-π/2;+π/2], is returned.
/// If a domain error occurs, an implementation-defined value is returned (NaN where supported).
/// If a range error occurs due to underflow, the correct result (after rounding) is returned.
@_disfavoredOverload
@inlinable
@inline(__always)
public func asin(_ x: Float) -> Float {
    FirebladeMathLibC.asinf(x)
}
