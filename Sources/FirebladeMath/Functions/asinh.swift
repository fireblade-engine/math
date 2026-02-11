import Foundation

#if canImport(Darwin)
import Darwin
#elseif canImport(Glibc)
import Glibc
#endif

/// Computes the inverse hyperbolic sine of x.
///
/// - Parameter x: floating point value representing the area of a hyperbolic sector
/// - Returns: If no errors occur, the inverse hyperbolic sine of x (sinh^-1(x), or arsinh(x)), is returned.
/// If a range error occurs due to underflow, the correct result (after rounding) is returned.
public func asinh(_ x: Double) -> Double {
    #if canImport(Darwin)
    return Darwin.asinh(x)
    #elseif canImport(Glibc)
    return Glibc.asinh(x)
    #else
    return Foundation.asinh(x)
    #endif
}

/// Computes the inverse hyperbolic sine of x.
///
/// - Parameter x: floating point value representing the area of a hyperbolic sector
/// - Returns: If no errors occur, the inverse hyperbolic sine of x (sinh^-1(x), or arsinh(x)), is returned.
/// If a range error occurs due to underflow, the correct result (after rounding) is returned.
public func asinh(_ x: Float) -> Float {
    #if canImport(Darwin)
    return Darwin.asinhf(x)
    #elseif canImport(Glibc)
    return Glibc.asinhf(x)
    #else
    return Foundation.asinhf(x)
    #endif
}
