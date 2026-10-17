import FirebladeMathLibC

/// Computes the cosine of arg (measured in radians).
///
/// - Parameter angleRad: floating point value representing angle in radians
/// - Returns: If no errors occur, the cosine of arg (cos(arg)) in the range [-1 ; +1], is returned.
/// If a domain error occurs, an implementation-defined value is returned (NaN where supported).
/// If a range error occurs due to underflow, the correct result (after rounding) is returned.
@inlinable
@_disfavoredOverload
public func cos(_ angleRad: Float) -> Float {
    FirebladeMathLibC.cosf(angleRad)
}

/// Computes the cosine of arg (measured in radians).
///
/// - Parameter angleRad:     floating point value representing angle in radians
/// - Returns: If no errors occur, the cosine of arg (cos(arg)) in the range [-1 ; +1], is returned.
/// If a domain error occurs, an implementation-defined value is returned (NaN where supported).
/// If a range error occurs due to underflow, the correct result (after rounding) is returned.
@inlinable
@_disfavoredOverload
public func cos(_ angleRad: Double) -> Double {
    FirebladeMathLibC.cos(angleRad)
}
