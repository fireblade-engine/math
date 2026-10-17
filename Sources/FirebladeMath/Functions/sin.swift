import FirebladeMathLibC

/// Computes the sine of arg (measured in radians).
///
/// - Parameter angleRad: floating point value representing an angle in radians
/// - Returns: If no errors occur, the sine of arg (sin(arg)) in the range [-1 ; +1], is returned.
/// If a domain error occurs, an implementation-defined value is returned (NaN where supported).
/// If a range error occurs due to underflow, the correct result (after rounding) is returned.
@inlinable
@_disfavoredOverload
public func sin(_ angleRad: Float) -> Float {
    FirebladeMathLibC.sinf(angleRad)
}

/// Computes the sine of arg (measured in radians).
///
/// - Parameter angleRad: floating point value representing an angle in radians
/// - Returns: If no errors occur, the sine of arg (sin(arg)) in the range [-1 ; +1], is returned.
/// If a domain error occurs, an implementation-defined value is returned (NaN where supported).
/// If a range error occurs due to underflow, the correct result (after rounding) is returned.
@inlinable
@_disfavoredOverload
public func sin(_ angleRad: Double) -> Double {
    FirebladeMathLibC.sin(angleRad)
}
