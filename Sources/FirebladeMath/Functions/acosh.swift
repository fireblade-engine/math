import Foundation

#if canImport(Darwin)
import Darwin
#elseif canImport(Glibc)
import Glibc
#endif

///  Computes the inverse hyperbolic cosine of x.
///
/// - Parameter x: floating point value representing the area of a hyperbolic sector
/// - Returns: If no errors occur, the inverse hyperbolic cosine of x (cosh-1
///    (x), or arcosh(x)) on the interval [0, +∞], is returned.
/// If a domain error occurs, an implementation-defined value is returned (NaN where supported).
public func acosh(_ x: Double) -> Double {
    #if canImport(Darwin)
    return Darwin.acosh(x)
    #elseif canImport(Glibc)
    return Glibc.acosh(x)
    #else
    return Foundation.acosh(x)
    #endif
}

///  Computes the inverse hyperbolic cosine of x.
///
/// - Parameter x: floating point value representing the area of a hyperbolic sector
/// - Returns: If no errors occur, the inverse hyperbolic cosine of x (cosh-1
///    (x), or arcosh(x)) on the interval [0, +∞], is returned.
/// If a domain error occurs, an implementation-defined value is returned (NaN where supported).
public func acosh(_ x: Float) -> Float {
    #if canImport(Darwin)
    return Darwin.acoshf(x)
    #elseif canImport(Glibc)
    return Glibc.acoshf(x)
    #else
    return Foundation.acoshf(x)
    #endif
}