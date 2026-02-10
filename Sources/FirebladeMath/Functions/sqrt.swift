import Foundation

#if canImport(Darwin)
import Darwin
#elseif canImport(Glibc)
import Glibc
#endif

/// Computes square root of arg.
///
/// - Parameter float:     floating point value
/// - Returns: If no errors occur, square root of arg (√arg), is returned.
/// If a domain error occurs, an implementation-defined value is returned (NaN where supported).
/// If a range error occurs due to underflow, the correct result (after rounding) is returned.
public func sqrt(_ float: Float) -> Float {
    #if canImport(Darwin)
    return Darwin.sqrtf(float)
    #elseif canImport(Glibc)
    return Glibc.sqrtf(float)
    #else
    return Foundation.sqrtf(float)
    #endif
}

/// Computes square root of arg.
///
/// - Parameter double:     floating point value
/// - Returns: If no errors occur, square root of arg (√arg), is returned.
/// If a domain error occurs, an implementation-defined value is returned (NaN where supported).
/// If a range error occurs due to underflow, the correct result (after rounding) is returned.
public func sqrt(_ double: Double) -> Double {
    #if canImport(Darwin)
    return Darwin.sqrt(double)
    #elseif canImport(Glibc)
    return Glibc.sqrt(double)
    #else
    return Foundation.sqrt(double)
    #endif
}
