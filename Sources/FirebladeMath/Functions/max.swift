import FirebladeMathLibC

/// Returns the larger of two floating point arguments, treating NaNs as missing data (between a NaN and a numeric value, the numeric value is chosen).
///
/// - Parameters:
///   - x: floating point value
///   - y: floating point value
/// - Returns: If successful, returns the larger of two floating point values. The value returned is exact and does not depend on any rounding modes.
@inlinable
@_disfavoredOverload
@available(*, deprecated, message: "Use Swift.max(_:_:) instead.", renamed: "Swift.max")
public func max(_ x: Float, _ y: Float) -> Float {
    FirebladeMathLibC.fmaxf(x, y)
}

/// Returns the larger of two floating point arguments, treating NaNs as missing data (between a NaN and a numeric value, the numeric value is chosen).
///
/// - Parameters:
///   - x: floating point value
///   - y: floating point value
/// - Returns: If successful, returns the larger of two floating point values. The value returned is exact and does not depend on any rounding modes.
@inlinable
@_disfavoredOverload
@available(*, deprecated, message: "Use Swift.max(_:_:) instead.", renamed: "Swift.max")
public func max(_ x: Double, _ y: Double) -> Double {
    FirebladeMathLibC.fmax(x, y)
}
