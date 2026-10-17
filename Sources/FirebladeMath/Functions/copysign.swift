import FirebladeMathLibC

/// Composes a floating point value with the magnitude of x and the sign of y.
///
/// - Parameters:
///   - x:     floating point value
///   - y:     floating point value
/// - Returns: If no errors occur, the floating point value with the magnitude of x and the sign of y is returned.
///            If x is NaN, then NaN with the sign of y is returned.
///            If y is -0, the result is only negative if the implementation supports the signed zero consistently in
///            arithmetic operations.
@_disfavoredOverload
public func copysign(_ x: Double, _ y: Double) -> Double {
    FirebladeMathLibC.copysign(x, y)
}

/// Composes a floating point value with the magnitude of x and the sign of y.
///
/// - Parameters:
///   - x:     floating point value
///   - y:     floating point value
/// - Returns: If no errors occur, the floating point value with the magnitude of x and the sign of y is returned.
///            If x is NaN, then NaN with the sign of y is returned.
///            If y is -0, the result is only negative if the implementation supports the signed zero consistently in
///            arithmetic operations.
@_disfavoredOverload
public func copysign(_ x: Float, _ y: Float) -> Float {
    FirebladeMathLibC.copysignf(x, y)
}
