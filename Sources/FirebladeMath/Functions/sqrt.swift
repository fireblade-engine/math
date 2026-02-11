import Foundation

#if canImport(Darwin)
import Darwin
#elseif canImport(Glibc)
import Glibc
#endif

/// Computes square root of x.
///
/// - Parameter x:     floating point value
/// - Returns: If no errors occur, square root of x (√x), is returned.
/// If a domain error occurs, an implementation-defined value is returned (NaN where supported).
/// If a range error occurs due to underflow, the correct result (after rounding) is returned.
public func sqrt(_ x: Float) -> Float {
    #if canImport(Darwin)
    return Darwin.sqrtf(x)
    #elseif canImport(Glibc)
    return Glibc.sqrtf(x)
    #else
    return Foundation.sqrtf(x)
    #endif
}

/// Computes square root of x.
///
/// - Parameter x:     floating point value
/// - Returns: If no errors occur, square root of x (√x), is returned.
/// If a domain error occurs, an implementation-defined value is returned (NaN where supported).
/// If a range error occurs due to underflow, the correct result (after rounding) is returned.
public func sqrt(_ x: Double) -> Double {
    #if canImport(Darwin)
    return Darwin.sqrt(x)
    #elseif canImport(Glibc)
    return Glibc.sqrt(x)
    #else
    return Foundation.sqrt(x)
    #endif
}