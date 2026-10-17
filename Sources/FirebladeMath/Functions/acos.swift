import FirebladeMathLibC

/// Computes the principal value of the arc cosine of x.
///
/// - Parameter x: floating point value
/// - Returns: If no errors occur, the arc cosine of x (arccos(x)) in the range [0 ; π], is returned.
///               If a domain error occurs, an implementation-defined value is returned (NaN where supported).
///                If a range error occurs due to underflow, the correct result (after rounding) is returned.
@_disfavoredOverload
public func acos(_ x: Float) -> Float {
    FirebladeMathLibC.acosf(x)
}

/// Computes the principal value of the arc cosine of x.
///
/// - Parameter x: floating point value
/// - Returns: If no errors occur, the arc cosine of x (arccos(x)) in the range [0 ; π], is returned.
///               If a domain error occurs, an implementation-defined value is returned (NaN where supported).
///                If a range error occurs due to underflow, the correct result (after rounding) is returned.
@_disfavoredOverload
public func acos(_ x: Double) -> Double {
    FirebladeMathLibC.acos(x)
}
