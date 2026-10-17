import FirebladeMathLibC

/// Computes the common (base-10) logarithm of x.
///
/// - Parameter x:     floating point value
/// - Returns: If no errors occur, the common (base-10) logarithm of x (log_10(x) or lg(x)) is returned.
/// If a domain error occurs, an implementation-defined value is returned (NaN where supported).
/// If a pole error occurs, -HUGE_VAL, -HUGE_VALF, or -HUGE_VALL is returned.
@_disfavoredOverload
@inlinable
@inline(__always)
public func log10(_ x: Float) -> Float {
    FirebladeMathLibC.log10f(x)
}

/// Computes the common (base-10) logarithm of x.
///
/// - Parameter x:     floating point value
/// - Returns: If no errors occur, the common (base-10) logarithm of x (log_10(x) or lg(x)) is returned.
/// If a domain error occurs, an implementation-defined value is returned (NaN where supported).
/// If a pole error occurs, -HUGE_VAL, -HUGE_VALF, or -HUGE_VALL is returned.
@_disfavoredOverload
@inlinable
@inline(__always)
public func log10(_ x: Double) -> Double {
    FirebladeMathLibC.log10(x)
}
