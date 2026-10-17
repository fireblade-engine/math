import FirebladeMathLibC

/// Computes the natural (base e) logarithm of x.
///
/// - Parameter x:     floating point value
/// - Returns: If no errors occur, the natural (base-e) logarithm of x (ln(x) or log_e(x)) is returned.
/// If a domain error occurs, an implementation-defined value is returned (NaN where supported).
/// If a pole error occurs, -HUGE_VAL, -HUGE_VALF, or -HUGE_VALL is returned.
@_disfavoredOverload
public func log(_ x: Float) -> Float {
    FirebladeMathLibC.logf(x)
}

/// Computes the natural (base e) logarithm of x.
///
/// - Parameter x:     floating point value
/// - Returns: If no errors occur, the natural (base-e) logarithm of x (ln(x) or log_e(x)) is returned.
/// If a domain error occurs, an implementation-defined value is returned (NaN where supported).
/// If a pole error occurs, -HUGE_VAL, -HUGE_VALF, or -HUGE_VALL is returned.
@_disfavoredOverload
public func log(_ x: Double) -> Double {
    FirebladeMathLibC.log(x)
}
