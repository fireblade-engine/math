import FirebladeMathLibC

///  Computes the base 2 logarithm of x.
///
/// - Parameter x:     floating point value
/// - Returns: If no errors occur, the base-2 logarithm of x (log_2(x) or lb(x)) is returned.
/// If a domain error occurs, an implementation-defined value is returned (NaN where supported).
/// If a pole error occurs, -HUGE_VAL, -HUGE_VALF, or -HUGE_VALL is returned.
@_disfavoredOverload
@inlinable
@inline(__always)
public func log2(_ x: Float) -> Float {
    FirebladeMathLibC.log2f(x)
}

///  Computes the base 2 logarithm of x.
///
/// - Parameter x:     floating point value
/// - Returns: If no errors occur, the base-2 logarithm of x (log_2(x) or lb(x)) is returned.
/// If a domain error occurs, an implementation-defined value is returned (NaN where supported).
/// If a pole error occurs, -HUGE_VAL, -HUGE_VALF, or -HUGE_VALL is returned.
@_disfavoredOverload
@inlinable
@inline(__always)
public func log2(_ x: Double) -> Double {
    FirebladeMathLibC.log2(x)
}
