import FirebladeMathLibC

/// Computes the hyperbolic tangent of x.
///
/// - Parameter x:     floating point value representing a hyperbolic angle
/// - Returns: If no errors occur, the hyperbolic tangent of x (tanh(x), or (e^x*-e^-x)/(e^x*+e^-x)) is returned.
/// If a range error occurs due to underflow, the correct result (after rounding) is returned.
@_disfavoredOverload
@inlinable
@inline(__always)
public func tanh(_ x: Float) -> Float {
    FirebladeMathLibC.tanhf(x)
}

/// Computes the hyperbolic tangent of x.
///
/// - Parameter x:     floating point value representing a hyperbolic angle
/// - Returns: If no errors occur, the hyperbolic tangent of x (tanh(x), or (e^x*-e^-x)/(e^x*+e^-x)) is returned.
/// If a range error occurs due to underflow, the correct result (after rounding) is returned.
@_disfavoredOverload
@inlinable
@inline(__always)
public func tanh(_ x: Double) -> Double {
    FirebladeMathLibC.tanh(x)
}
