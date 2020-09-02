#if canImport(Darwin)
import Darwin.C.math
#elseif canImport(Glibc)
import Glibc
#else
#error("unsupported platform")
#endif

/// Computes square root of arg.
///
/// - Parameter float:     floating point value
/// - Returns: If no errors occur, square root of arg (√arg), is returned.
/// If a domain error occurs, an implementation-defined value is returned (NaN where supported).
/// If a range error occurs due to underflow, the correct result (after rounding) is returned.
public func sqrt(_ float: Float) -> Float {
    sqrtf(float)
}

/// Computes square root of arg.
///
/// - Parameter double:     floating point value
/// - Returns: If no errors occur, square root of arg (√arg), is returned.
/// If a domain error occurs, an implementation-defined value is returned (NaN where supported).
/// If a range error occurs due to underflow, the correct result (after rounding) is returned.
public func sqrt(_ double: Double) -> Double {
    #if os(macOS) || os(iOS) || os(tvOS)
    return Darwin.sqrt(double)
    #elseif os(Linux)
    return Glibc.sqrt(double)
    #endif
}
