import FirebladeMathLibC

///  Computes the inverse hyperbolic cosine of x.
///
/// - Parameter x: floating point value representing the area of a hyperbolic sector
/// - Returns: If no errors occur, the inverse hyperbolic cosine of x (cosh-1
///    (x), or arcosh(x)) on the interval [0, +∞], is returned.
/// If a domain error occurs, an implementation-defined value is returned (NaN where supported).
@_disfavoredOverload
public func acosh(_ x: Double) -> Double {
    FirebladeMathLibC.acosh(x)
}

///  Computes the inverse hyperbolic cosine of x.
///
/// - Parameter x: floating point value representing the area of a hyperbolic sector
/// - Returns: If no errors occur, the inverse hyperbolic cosine of x (cosh-1
///    (x), or arcosh(x)) on the interval [0, +∞], is returned.
/// If a domain error occurs, an implementation-defined value is returned (NaN where supported).
@_disfavoredOverload
public func acosh(_ x: Float) -> Float {
    FirebladeMathLibC.acoshf(x)
}
