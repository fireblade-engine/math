import Foundation

#if canImport(Darwin)
import Darwin
#elseif canImport(Glibc)
import Glibc
#endif

/// Computes hyperbolic sine of arg.
///
/// - Parameter float:     floating point value representing a hyperbolic angle
/// - Returns: If no errors occur, the hyperbolic sine of arg (sinh(arg), or (e^arg*-e-arg)/2) is returned.
/// If a range error due to overflow occurs, ±HUGE_VAL, ±HUGE_VALF, or ±HUGE_VALL is returned.
/// If a range error occurs due to underflow, the correct result (after rounding) is returned.
public func sinh(_ float: Float) -> Float {
    #if canImport(Darwin)
    return Darwin.sinhf(float)
    #elseif canImport(Glibc)
    return Glibc.sinhf(float)
    #else
    return Foundation.sinhf(float)
    #endif
}

/// Computes hyperbolic sine of arg.
///
/// - Parameter double:     floating point value representing a hyperbolic angle
/// - Returns: If no errors occur, the hyperbolic sine of arg (sinh(arg), or (e^arg*-e-arg)/2) is returned.
/// If a range error due to overflow occurs, ±HUGE_VAL, ±HUGE_VALF, or ±HUGE_VALL is returned.
/// If a range error occurs due to underflow, the correct result (after rounding) is returned.
public func sinh(_ double: Double) -> Double {
    #if canImport(Darwin)
    return Darwin.sinh(double)
    #elseif canImport(Glibc)
    return Glibc.sinh(double)
    #else
    return Foundation.sinh(double)
    #endif
}
