import Foundation

#if canImport(Darwin)
import Darwin
#elseif canImport(Glibc)
import Glibc
#endif

/// Computes the principal values of the arc sine of arg.
///
/// - Parameter double:     floating point value
/// - Returns: If no errors occur, the arc sine of arg (arcsin(arg)) in the range [-π/2;+π/2], is returned.
/// If a domain error occurs, an implementation-defined value is returned (NaN where supported).
/// If a range error occurs due to underflow, the correct result (after rounding) is returned.
public func asin(_ double: Double) -> Double {
    #if canImport(Darwin)
    return Darwin.asin(double)
    #elseif canImport(Glibc)
    return Glibc.asin(double)
    #else
    return Foundation.asin(double)
    #endif
}

/// Computes the principal values of the arc sine of arg.
///
/// - Parameter float:     floating point value
/// - Returns: If no errors occur, the arc sine of arg (arcsin(arg)) in the range [-π/2;+π/2], is returned.
/// If a domain error occurs, an implementation-defined value is returned (NaN where supported).
/// If a range error occurs due to underflow, the correct result (after rounding) is returned.
public func asin(_ float: Float) -> Float {
    #if canImport(Darwin)
    return Darwin.asinf(float)
    #elseif canImport(Glibc)
    return Glibc.asinf(float)
    #else
    return Foundation.asinf(float)
    #endif
}
