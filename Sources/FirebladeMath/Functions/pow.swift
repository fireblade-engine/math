import Foundation

#if canImport(Darwin)
import Darwin
#elseif canImport(Glibc)
import Glibc
#endif

/// Computes the value of base raised to the power exponent.
///
/// - Parameters:
///   - base:     base as floating point value
///   - exponent: exponent as floating point value
/// - Returns: If no errors occur, base raised to the power of exponent (base^exponent) is returned.
/// If a domain error occurs, an implementation-defined value is returned (NaN where supported).
/// If a pole error or a range error due to overflow occurs, ±HUGE_VAL, ±HUGE_VALF, or ±HUGE_VALL is returned.
/// If a range error occurs due to underflow, the correct result (after rounding) is returned.
public func pow(_ base: Float, _ exponent: Float) -> Float {
    #if canImport(Darwin)
    return Darwin.powf(base, exponent)
    #elseif canImport(Glibc)
    return Glibc.powf(base, exponent)
    #else
    return Foundation.powf(base, exponent)
    #endif
}

/// Computes the value of base raised to the power exponent.
///
/// - Parameters:
///   - base:     base as floating point value
///   - exponent: exponent as floating point value
/// - Returns: If no errors occur, base raised to the power of exponent (base^exponent) is returned.
/// If a domain error occurs, an implementation-defined value is returned (NaN where supported).
/// If a pole error or a range error due to overflow occurs, ±HUGE_VAL, ±HUGE_VALF, or ±HUGE_VALL is returned.
/// If a range error occurs due to underflow, the correct result (after rounding) is returned.
public func pow(_ base: Double, _ exponent: Double) -> Double {
    #if canImport(Darwin)
    return Darwin.pow(base, exponent)
    #elseif canImport(Glibc)
    return Glibc.pow(base, exponent)
    #else
    return Foundation.pow(base, exponent)
    #endif
}
