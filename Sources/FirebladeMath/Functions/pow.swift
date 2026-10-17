import FirebladeMathLibC

/// Computes the value of base raised to the power exponent.
///
/// - Parameters:
///   - base:     base as floating point value
///   - exponent: exponent as floating point value
/// - Returns: If no errors occur, base raised to the power of exponent (base^exponent) is returned.
/// If a domain error occurs, an implementation-defined value is returned (NaN where supported).
/// If a pole error or a range error due to overflow occurs, ±HUGE_VAL, ±HUGE_VALF, or ±HUGE_VALL is returned.
/// If a range error occurs due to underflow, the correct result (after rounding) is returned.
@_disfavoredOverload
public func pow(_ base: Float, _ exponent: Float) -> Float {
    FirebladeMathLibC.powf(base, exponent)
}

/// Computes the value of base raised to the power exponent.
///
/// - Parameters:
///   - base:     base as floating point value
///   - exponent: exponent as floating point value
/// - Returns: If no errors occur, base raised to the power of exponent (base^exponent) is returned.
/// If a domain error occurs, an implementation-defined value is returned (NaN where supported).
/// If a pole error or a range error due to overflow occurs, ±HUGE_VAL, ±HUGE_VALF, or ±HUGE_VALL is returned.
/// If a range error occurs due to underflow, the correct result (after rounding) is returned.
@_disfavoredOverload
public func pow(_ base: Double, _ exponent: Double) -> Double {
    FirebladeMathLibC.pow(base, exponent)
}
