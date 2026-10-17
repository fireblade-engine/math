import FirebladeMathLibC

/// Computes square root of x.
///
/// - Parameter x:     floating point value
/// - Returns: If no errors occur, square root of x (√x), is returned.
/// If a domain error occurs, an implementation-defined value is returned (NaN where supported).
/// If a range error occurs due to underflow, the correct result (after rounding) is returned.
@_disfavoredOverload
@inlinable
@inline(__always)
public func sqrt(_ x: Float) -> Float {
    FirebladeMathLibC.sqrtf(x)
}

/// Computes square root of x.
///
/// - Parameter x:     floating point value
/// - Returns: If no errors occur, square root of x (√x), is returned.
/// If a domain error occurs, an implementation-defined value is returned (NaN where supported).
/// If a range error occurs due to underflow, the correct result (after rounding) is returned.
@_disfavoredOverload
@inlinable
@inline(__always)
public func sqrt(_ x: Double) -> Double {
    FirebladeMathLibC.sqrt(x)
}
