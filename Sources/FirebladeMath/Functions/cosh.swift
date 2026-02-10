import Foundation

#if canImport(Darwin)
import Darwin
#elseif canImport(Glibc)
import Glibc
#endif

/// Computes the hyperbolic cosine of arg.
///
/// - Parameter float: floating point value representing a hyperbolic angle
/// - Returns: If no errors occur, the hyperbolic cosine of arg (cosh(arg), or (e^arg+e^-arg)/2) is returned.
/// If a range error due to overflow occurs, +HUGE_VAL, +HUGE_VALF, or +HUGE_VALL is returned.
public func cosh(_ float: Float) -> Float {
    #if canImport(Darwin)
    return Darwin.coshf(float)
    #elseif canImport(Glibc)
    return Glibc.coshf(float)
    #else
    return Foundation.coshf(float)
    #endif
}

/// Computes the hyperbolic cosine of arg.
///
/// - Parameter double: floating point value representing a hyperbolic angle
/// - Returns: If no errors occur, the hyperbolic cosine of arg (cosh(arg), or (e^arg+e^-arg)/2) is returned.
/// If a range error due to overflow occurs, +HUGE_VAL, +HUGE_VALF, or +HUGE_VALL is returned.
public func cosh(_ double: Double) -> Double {
    #if canImport(Darwin)
    return Darwin.cosh(double)
    #elseif canImport(Glibc)
    return Glibc.cosh(double)
    #else
    return Foundation.cosh(double)
    #endif
}