import FirebladeMathLibC

///  The atan2() function computes the principal value of the arc tangent of y/x,
///  using the signs of both arguments to determine the quadrant of the return value.
/// - Parameter y: The y coordinate.
/// - Parameter x: The x coordinate.
/// - Returns: The arc tangent of y/x in radians.
@_disfavoredOverload
@inlinable
@inline(__always)
public func atan2(_ y: Double, _ x: Double) -> Double {
    FirebladeMathLibC.atan2(y, x)
}

///  The atan2() function computes the principal value of the arc tangent of y/x,
///  using the signs of both arguments to determine the quadrant of the return value.
/// - Parameter y: The y coordinate.
/// - Parameter x: The x coordinate.
/// - Returns: The arc tangent of y/x in radians.
@_disfavoredOverload
@inlinable
@inline(__always)
public func atan2(_ y: Float, _ x: Float) -> Float {
    FirebladeMathLibC.atan2f(y, x)
}
