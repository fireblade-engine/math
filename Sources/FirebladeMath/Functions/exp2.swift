import FirebladeMathLibC

/// Computes 2 raised to the given power n.
///
/// - Parameter power:     floating point value
/// - Returns: If no errors occur, the base-2 exponential of n (2^n) is returned.
/// If a range error due to overflow occurs, +HUGE_VAL, +HUGE_VALF, or +HUGE_VALL is returned.
/// If a range error occurs due to underflow, the correct result (after rounding) is returned.
@_disfavoredOverload
@inlinable
@inline(__always)
public func exp2(_ power: Float) -> Float {
    FirebladeMathLibC.exp2f(power)
}

/// Computes 2 raised to the given power n.
///
/// - Parameter power:     floating point value
/// - Returns: If no errors occur, the base-2 exponential of n (2^n) is returned.
/// If a range error due to overflow occurs, +HUGE_VAL, +HUGE_VALF, or +HUGE_VALL is returned.
/// If a range error occurs due to underflow, the correct result (after rounding) is returned.
@_disfavoredOverload
@inlinable
@inline(__always)
public func exp2(_ power: Double) -> Double {
    FirebladeMathLibC.exp2(power)
}
