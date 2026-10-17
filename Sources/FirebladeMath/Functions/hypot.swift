import FirebladeMathLibC

/// Returns the hypotenuse of a right-angled triangle whose legs are x and y.
/// - Parameter x: x
/// - Parameter y: y
@_disfavoredOverload
@inlinable
@inline(__always)
public func hypot(_ x: Float, _ y: Float) -> Float {
    FirebladeMathLibC.hypotf(x, y)
}

/// Returns the hypotenuse of a right-angled triangle whose legs are x and y.
/// - Parameter x: x
/// - Parameter y: y
@_disfavoredOverload
@inlinable
@inline(__always)
public func hypot(_ x: Double, _ y: Double) -> Double {
    FirebladeMathLibC.hypot(x, y)
}
