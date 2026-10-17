import FirebladeMathLibC

/// Computes the largest integer value not greater than x.
///
/// - Parameter x: floating point value
/// - Returns: If no errors occur, the largest integer value not greater than x, that is ⌊x⌋, is returned.
@_disfavoredOverload
@inlinable
@inline(__always)
public func floor(_ x: Float) -> Float {
    FirebladeMathLibC.floorf(x)
}

/// Computes the largest integer value not greater than x.
///
/// - Parameter x: floating point value
/// - Returns: If no errors occur, the largest integer value not greater than x, that is ⌊x⌋, is returned.
@_disfavoredOverload
@inlinable
@inline(__always)
public func floor(_ x: Double) -> Double {
    FirebladeMathLibC.floor(x)
}
