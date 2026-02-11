import Foundation

#if canImport(Darwin)
import Darwin
#elseif canImport(Glibc)
import Glibc
#endif

/// Computes hyperbolic sine of x.
///
/// - Parameter x:     floating point value representing a hyperbolic angle
/// - Returns: If no errors occur, the hyperbolic sine of x (sinh(x), or (e^x*-e-x)/2) is returned.
/// If a range error due to overflow occurs, ±HUGE_VAL, ±HUGE_VALF, or ±HUGE_VALL is returned.
/// If a range error occurs due to underflow, the correct result (after rounding) is returned.
public func sinh(_ x: Float) -> Float {
    #if canImport(Darwin)
    return Darwin.sinhf(x)
    #elseif canImport(Glibc)
    return Glibc.sinhf(x)
    #else
    return Foundation.sinhf(x)
    #endif
}

/// Computes hyperbolic sine of x.
///
/// - Parameter x:     floating point value representing a hyperbolic angle
/// - Returns: If no errors occur, the hyperbolic sine of x (sinh(x), or (e^x*-e-x)/2) is returned.
/// If a range error due to overflow occurs, ±HUGE_VAL, ±HUGE_VALF, or ±HUGE_VALL is returned.
/// If a range error occurs due to underflow, the correct result (after rounding) is returned.
public func sinh(_ x: Double) -> Double {
    #if canImport(Darwin)
    return Darwin.sinh(x)
    #elseif canImport(Glibc)
    return Glibc.sinh(x)
    #else
    return Foundation.sinh(x)
    #endif
}