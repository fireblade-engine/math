import FirebladeMathLibC

/// Returns the smaller of two floating point arguments, treating NaNs as missing data (between a NaN and a numeric value, the numeric value is chosen).
///
/// - Parameters:
///   - x: floating point value
///   - y: floating point value
/// - Returns: If successful, returns the smaller of two floating point values. The value returned is exact and does not depend on any rounding modes.
@inlinable
@_disfavoredOverload
@available(*, deprecated, message: "Use Swift.min(_:_:) instead.", renamed: "Swift.min")
public func min(_ x: Float, _ y: Float) -> Float {
    FirebladeMathLibC.fminf(x, y)
}

/// Returns the smaller of two floating point arguments, treating NaNs as missing data (between a NaN and a numeric value, the numeric value is chosen).
///
/// - Parameters:
///   - x: floating point value
///   - y: floating point value
/// - Returns: If successful, returns the smaller of two floating point values. The value returned is exact and does not depend on any rounding modes.
@inlinable
@_disfavoredOverload
@available(*, deprecated, message: "Use Swift.min(_:_:) instead.", renamed: "Swift.min")
public func min(_ x: Double, _ y: Double) -> Double {
    FirebladeMathLibC.fmin(x, y)
}
