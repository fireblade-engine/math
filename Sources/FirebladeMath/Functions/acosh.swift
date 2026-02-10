import Foundation

#if canImport(Darwin)
import Darwin
#elseif canImport(Glibc)
import Glibc
#endif

///  Computes the inverse hyperbolic cosine of arg.
///
/// - Parameter double:     floating point value representing the area of a hyperbolic sector
/// - Returns: If no errors occur, the inverse hyperbolic cosine of arg (cosh-1
///    (arg), or arcosh(arg)) on the interval [0, +∞], is returned.
/// If a domain error occurs, an implementation-defined value is returned (NaN where supported).
public func acosh(_ double: Double) -> Double {
    #if canImport(Darwin)
    return Darwin.acosh(double)
    #elseif canImport(Glibc)
    return Glibc.acosh(double)
    #else
    return Foundation.acosh(double)
    #endif
}

///  Computes the inverse hyperbolic cosine of arg.
///
/// - Parameter float:     floating point value representing the area of a hyperbolic sector
/// - Returns: If no errors occur, the inverse hyperbolic cosine of arg (cosh-1
///    (arg), or arcosh(arg)) on the interval [0, +∞], is returned.
/// If a domain error occurs, an implementation-defined value is returned (NaN where supported).
public func acosh(_ float: Float) -> Float {
    #if canImport(Darwin)
    return Darwin.acoshf(float)
    #elseif canImport(Glibc)
    return Glibc.acoshf(float)
    #else
    return Foundation.acoshf(float)
    #endif
}