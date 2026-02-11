import Foundation

#if canImport(Darwin)
import Darwin
#elseif canImport(Glibc)
import Glibc
#endif

/// Computes the principal values of the arc sine of x.
///
/// - Parameter x: floating point value
/// - Returns: If no errors occur, the arc sine of x (arcsin(x)) in the range [-π/2;+π/2], is returned.
/// If a domain error occurs, an implementation-defined value is returned (NaN where supported).
/// If a range error occurs due to underflow, the correct result (after rounding) is returned.
public func asin(_ x: Double) -> Double {
    #if canImport(Darwin)
    return Darwin.asin(x)
    #elseif canImport(Glibc)
    return Glibc.asin(x)
    #else
    return Foundation.asin(x)
    #endif
}

/// Computes the principal values of the arc sine of x.
///
/// - Parameter x: floating point value
/// - Returns: If no errors occur, the arc sine of x (arcsin(x)) in the range [-π/2;+π/2], is returned.
/// If a domain error occurs, an implementation-defined value is returned (NaN where supported).
/// If a range error occurs due to underflow, the correct result (after rounding) is returned.
public func asin(_ x: Float) -> Float {
    #if canImport(Darwin)
    return Darwin.asinf(x)
    #elseif canImport(Glibc)
    return Glibc.asinf(x)
    #else
    return Foundation.asinf(x)
    #endif
}
