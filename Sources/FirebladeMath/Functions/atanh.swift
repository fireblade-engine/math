import Foundation

#if canImport(Darwin)
import Darwin
#elseif canImport(Glibc)
import Glibc
#endif

/// Computes the inverse hyperbolic tangent of x.
///
/// - Parameter x: floating point value representing the area of a hyperbolic sector
/// - Returns: If no errors occur, the inverse hyperbolic tangent of x (tanh^-1(x), or artanh(x)), is returned.
/// If a domain error occurs, an implementation-defined value is returned (NaN where supported).
/// If a pole error occurs, ±HUGE_VAL, ±HUGE_VALF, or ±HUGE_VALL is returned (with the correct sign).
/// If a range error occurs due to underflow, the correct result (after rounding) is returned.
public func atanh(_ x: Float) -> Float {
    #if canImport(Darwin)
    return Darwin.atanhf(x)
    #elseif canImport(Glibc)
    return Glibc.atanhf(x)
    #else
    return Foundation.atanhf(x)
    #endif
}

/// Computes the inverse hyperbolic tangent of x.
///
/// - Parameter x: floating point value representing the area of a hyperbolic sector
/// - Returns: If no errors occur, the inverse hyperbolic tangent of x (tanh^-1(x), or artanh(x)), is returned.
/// If a domain error occurs, an implementation-defined value is returned (NaN where supported).
/// If a pole error occurs, ±HUGE_VAL, ±HUGE_VALF, or ±HUGE_VALL is returned (with the correct sign).
/// If a range error occurs due to underflow, the correct result (after rounding) is returned.
public func atanh(_ x: Double) -> Double {
    #if canImport(Darwin)
    return Darwin.atanh(x)
    #elseif canImport(Glibc)
    return Glibc.atanh(x)
    #else
    return Foundation.atanh(x)
    #endif
}
