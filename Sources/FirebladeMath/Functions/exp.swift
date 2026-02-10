import Foundation

#if canImport(Darwin)
import Darwin
#elseif canImport(Glibc)
import Glibc
#endif

///  Computes the e (Euler's number, 2.7182818) raised to the given power arg.
///
/// - Parameter float: floating point value
/// - Returns: If no errors occur, the base-e exponential of arg (e^arg) is returned.
/// If a range error due to overflow occurs, +HUGE_VAL, +HUGE_VALF, or +HUGE_VALL is returned.
/// If a range error occurs due to underflow, the correct result (after rounding) is returned.
public func exp(_ power: Float) -> Float {
    #if canImport(Darwin)
    return Darwin.expf(power)
    #elseif canImport(Glibc)
    return Glibc.expf(power)
    #else
    return Foundation.expf(power)
    #endif
}

///  Computes the e (Euler's number, 2.7182818) raised to the given power arg.
///
/// - Parameter double: floating point value
/// - Returns: If no errors occur, the base-e exponential of arg (e^arg) is returned.
/// If a range error due to overflow occurs, +HUGE_VAL, +HUGE_VALF, or +HUGE_VALL is returned.
/// If a range error occurs due to underflow, the correct result (after rounding) is returned.
public func exp(_ power: Double) -> Double {
    #if canImport(Darwin)
    return Darwin.exp(power)
    #elseif canImport(Glibc)
    return Glibc.exp(power)
    #else
    return Foundation.exp(power)
    #endif
}
