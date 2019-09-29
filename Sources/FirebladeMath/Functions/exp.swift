#if canImport(Darwin)
import Darwin.C.math
#elseif canImport(Glibc)
import Glibc
#else
#error("unsupported platform")
#endif

///  Computes the e (Euler's number, 2.7182818) raised to the given power arg.
///
/// - Parameter float: floating point value
/// - Returns: If no errors occur, the base-e exponential of arg (e^arg) is returned.
/// If a range error due to overflow occurs, +HUGE_VAL, +HUGE_VALF, or +HUGE_VALL is returned.
/// If a range error occurs due to underflow, the correct result (after rounding) is returned.
public func exp(_ power: Float32) -> Float32 {
    #if os(macOS) || os(iOS) || os(tvOS)
    return Darwin.expf(power)
    #elseif os(Linux)
    return Glibc.expf(power)
    #endif
}

///  Computes the e (Euler's number, 2.7182818) raised to the given power arg.
///
/// - Parameter double: floating point value
/// - Returns: If no errors occur, the base-e exponential of arg (e^arg) is returned.
/// If a range error due to overflow occurs, +HUGE_VAL, +HUGE_VALF, or +HUGE_VALL is returned.
/// If a range error occurs due to underflow, the correct result (after rounding) is returned.
public func exp(_ power: Float64) -> Float64 {
    #if os(macOS) || os(iOS) || os(tvOS)
    return Darwin.exp(power)
    #elseif os(Linux)
    return Glibc.exp(power)
    #endif
}
