import FirebladeMathLibC

/// Computes the absolute value of a floating point value x.
///
/// - Parameter x: floating point value
/// - Returns: If successful, returns the absolute value of x (|x|). The value returned is exact and does not depend on any rounding modes.
@_disfavoredOverload
@available(*, deprecated, message: "Use Swift.abs(_:) or x.magnitude instead.", renamed: "Swift.abs")
@inlinable
@inline(__always)
public func abs(_ x: Float) -> Float {
    FirebladeMathLibC.fabsf(x)
}

/// Computes the absolute value of a floating point value x.
///
/// - Parameter x: floating point value
/// - Returns: If successful, returns the absolute value of x (|x|). The value returned is exact and does not depend on any rounding modes.
@_disfavoredOverload
@available(*, deprecated, message: "Use Swift.abs(_:) or x.magnitude instead.", renamed: "Swift.abs")
@inlinable
@inline(__always)
public func abs(_ x: Double) -> Double {
    FirebladeMathLibC.fabs(x)
}
