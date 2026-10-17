import FirebladeMathLibC

/// Computes the tangent of arg (measured in radians).
///
/// - Parameter angleRad:     floating point value representing angle in radians
/// - Returns: If no errors occur, the tangent of arg (tan(arg)) is returned.
/// If a domain error occurs, an implementation-defined value is returned (NaN where supported).
/// If a range error occurs due to underflow, the correct result (after rounding) is returned.
@inlinable
@_disfavoredOverload
public func tan(_ angleRad: Float) -> Float {
    FirebladeMathLibC.tanf(angleRad)
}

/// Computes the tangent of arg (measured in radians).
///
/// - Parameter angleRad:     floating point value representing angle in radians
/// - Returns: If no errors occur, the tangent of arg (tan(arg)) is returned.
/// If a domain error occurs, an implementation-defined value is returned (NaN where supported).
/// If a range error occurs due to underflow, the correct result (after rounding) is returned.
@inlinable
@_disfavoredOverload
public func tan(_ angleRad: Double) -> Double {
    FirebladeMathLibC.tan(angleRad)
}
