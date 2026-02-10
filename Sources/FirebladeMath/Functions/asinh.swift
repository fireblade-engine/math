import Foundation

#if canImport(Darwin)
import Darwin
#elseif canImport(Glibc)
import Glibc
#endif

/// Computes the inverse hyperbolic sine of arg.
///
/// - Parameter double: floating point value representing the area of a hyperbolic sector
/// - Returns: If no errors occur, the inverse hyperbolic sine of arg (sinh^-1(arg), or arsinh(arg)), is returned.
/// If a range error occurs due to underflow, the correct result (after rounding) is returned.
public func asinh(_ double: Double) -> Double {
    #if canImport(Darwin)
    return Darwin.asinh(double)
    #elseif canImport(Glibc)
    return Glibc.asinh(double)
    #else
    return Foundation.asinh(double)
    #endif
}

/// Computes the inverse hyperbolic sine of arg.
///
/// - Parameter float: floating point value representing the area of a hyperbolic sector
/// - Returns: If no errors occur, the inverse hyperbolic sine of arg (sinh^-1(arg), or arsinh(arg)), is returned.
/// If a range error occurs due to underflow, the correct result (after rounding) is returned.
public func asinh(_ float: Float) -> Float {
    #if canImport(Darwin)
    return Darwin.asinhf(float)
    #elseif canImport(Glibc)
    return Glibc.asinhf(float)
    #else
    return Foundation.asinhf(float)
    #endif
}
