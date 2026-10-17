import FirebladeMathLibC

/// Computes the smallest integer value not less than x.
///
/// - Parameter x:     floating point value
/// - Returns: If no errors occur, the smallest integer value not less than x, that is ⌈x⌉, is returned.
@_disfavoredOverload
@inlinable
@inline(__always)
public func ceil(_ x: Float) -> Float {
    FirebladeMathLibC.ceilf(x)
}

/// Computes the smallest integer value not less than x.
///
/// - Parameter x:     floating point value
/// - Returns: If no errors occur, the smallest integer value not less than x, that is ⌈x⌉, is returned.
@_disfavoredOverload
@inlinable
@inline(__always)
public func ceil(_ x: Double) -> Double {
    FirebladeMathLibC.ceil(x)
}
