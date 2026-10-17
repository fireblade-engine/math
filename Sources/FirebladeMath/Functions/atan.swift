import FirebladeMathLibC

/// Computes the principal value of the arc tangent of x.
///
/// - Parameter x: floating point value
/// - Returns: If no errors occur, the arc tangent of x (arctan(x)) in the range [-π/2;+π/2] radians, is returned.
/// If a range error occurs due to underflow, the correct result (after rounding) is returned.
@inlinable
@_disfavoredOverload
public func atan(_ x: Double) -> Double {
    FirebladeMathLibC.atan(x)
}

/// Computes the principal value of the arc tangent of x.
///
/// - Parameter x: floating point value
/// - Returns: If no errors occur, the arc tangent of x (arctan(x)) in the range [-π/2;+π/2] radians, is returned.
/// If a range error occurs due to underflow, the correct result (after rounding) is returned.
@inlinable
@_disfavoredOverload
public func atan(_ x: Float) -> Float {
    FirebladeMathLibC.atanf(x)
}
