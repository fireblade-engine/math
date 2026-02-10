import Foundation

#if canImport(Darwin)
import Darwin
#elseif canImport(Glibc)
import Glibc
#endif

/// Computes the inverse hyperbolic tangent of arg.
///
/// - Parameter float: floating point value representing the area of a hyperbolic sector
/// - Returns: If no errors occur, the inverse hyperbolic tangent of arg (tanh^-1(arg), or artanh(arg)), is returned.
/// If a domain error occurs, an implementation-defined value is returned (NaN where supported).
/// If a pole error occurs, ±HUGE_VAL, ±HUGE_VALF, or ±HUGE_VALL is returned (with the correct sign).
/// If a range error occurs due to underflow, the correct result (after rounding) is returned.
public func atanh(_ float: Float) -> Float {
    #if canImport(Darwin)
    return Darwin.atanhf(float)
    #elseif canImport(Glibc)
    return Glibc.atanhf(float)
    #else
    return Foundation.atanhf(float)
    #endif
}

/// Computes the inverse hyperbolic tangent of arg.
///
/// - Parameter double: floating point value representing the area of a hyperbolic sector
/// - Returns: If no errors occur, the inverse hyperbolic tangent of arg (tanh^-1(arg), or artanh(arg)), is returned.
/// If a domain error occurs, an implementation-defined value is returned (NaN where supported).
/// If a pole error occurs, ±HUGE_VAL, ±HUGE_VALF, or ±HUGE_VALL is returned (with the correct sign).
/// If a range error occurs due to underflow, the correct result (after rounding) is returned.
public func atanh(_ double: Double) -> Double {
    #if canImport(Darwin)
    return Darwin.atanh(double)
    #elseif canImport(Glibc)
    return Glibc.atanh(double)
    #else
    return Foundation.atanh(double)
    #endif
}