import FirebladeMathLibC

///  Computes the e (Euler's number, 2.7182818) raised to the given power arg.
///
/// - Parameter power: floating point value
/// - Returns: If no errors occur, the base-e exponential of arg (e^arg) is returned.
/// If a range error due to overflow occurs, +HUGE_VAL, +HUGE_VALF, or +HUGE_VALL is returned.
/// If a range error occurs due to underflow, the correct result (after rounding) is returned.
@_disfavoredOverload
@inlinable
@inline(__always)
public func exp(_ power: Float) -> Float {
    FirebladeMathLibC.expf(power)
}

///  Computes the e (Euler's number, 2.7182818) raised to the given power arg.
///
/// - Parameter power: floating point value
/// - Returns: If no errors occur, the base-e exponential of arg (e^arg) is returned.
/// If a range error due to overflow occurs, +HUGE_VAL, +HUGE_VALF, or +HUGE_VALL is returned.
/// If a range error occurs due to underflow, the correct result (after rounding) is returned.
@_disfavoredOverload
@inlinable
@inline(__always)
public func exp(_ power: Double) -> Double {
    FirebladeMathLibC.exp(power)
}
