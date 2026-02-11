import Foundation

#if canImport(Darwin)
import Darwin
#elseif canImport(Glibc)
import Glibc
#endif

/// Computes the hyperbolic cosine of x.
///
/// - Parameter x: floating point value representing a hyperbolic angle
/// - Returns: If no errors occur, the hyperbolic cosine of x (cosh(x), or (e^x+e^-x)/2) is returned.
/// If a range error due to overflow occurs, +HUGE_VAL, +HUGE_VALF, or +HUGE_VALL is returned.
public func cosh(_ x: Float) -> Float {
    #if canImport(Darwin)
    return Darwin.coshf(x)
    #elseif canImport(Glibc)
    return Glibc.coshf(x)
    #else
    return Foundation.coshf(x)
    #endif
}

/// Computes the hyperbolic cosine of x.
///
/// - Parameter x: floating point value representing a hyperbolic angle
/// - Returns: If no errors occur, the hyperbolic cosine of x (cosh(x), or (e^x+e^-x)/2) is returned.
/// If a range error due to overflow occurs, +HUGE_VAL, +HUGE_VALF, or +HUGE_VALL is returned.
public func cosh(_ x: Double) -> Double {
    #if canImport(Darwin)
    return Darwin.cosh(x)
    #elseif canImport(Glibc)
    return Glibc.cosh(x)
    #else
    return Foundation.cosh(x)
    #endif
}
