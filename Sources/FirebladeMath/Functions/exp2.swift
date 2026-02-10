import Foundation

#if canImport(Darwin)
import Darwin
#elseif canImport(Glibc)
import Glibc
#endif

/// Computes 2 raised to the given power n.
///
/// - Parameter float:     floating point value
/// - Returns: If no errors occur, the base-2 exponential of n (2^n) is returned.
/// If a range error due to overflow occurs, +HUGE_VAL, +HUGE_VALF, or +HUGE_VALL is returned.
/// If a range error occurs due to underflow, the correct result (after rounding) is returned.
public func exp2(_ power: Float) -> Float {
    #if canImport(Darwin)
    return Darwin.exp2f(power)
    #elseif canImport(Glibc)
    return Glibc.exp2f(power)
    #else
    return Foundation.exp2f(power)
    #endif
}

/// Computes 2 raised to the given power n.
///
/// - Parameter double:     floating point value
/// - Returns: If no errors occur, the base-2 exponential of n (2^n) is returned.
/// If a range error due to overflow occurs, +HUGE_VAL, +HUGE_VALF, or +HUGE_VALL is returned.
/// If a range error occurs due to underflow, the correct result (after rounding) is returned.
public func exp2(_ power: Double) -> Double {
    #if canImport(Darwin)
    return Darwin.exp2(power)
    #elseif canImport(Glibc)
    return Glibc.exp2(power)
    #else
    return Foundation.exp2(power)
    #endif
}