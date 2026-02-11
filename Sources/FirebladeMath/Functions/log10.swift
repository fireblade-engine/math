import Foundation

#if canImport(Darwin)
import Darwin
#elseif canImport(Glibc)
import Glibc
#endif

/// Computes the common (base-10) logarithm of x.
///
/// - Parameter x:     floating point value
/// - Returns: If no errors occur, the common (base-10) logarithm of x (log_10(x) or lg(x)) is returned.
/// If a domain error occurs, an implementation-defined value is returned (NaN where supported).
/// If a pole error occurs, -HUGE_VAL, -HUGE_VALF, or -HUGE_VALL is returned.
public func log10(_ x: Float) -> Float {
    #if canImport(Darwin)
    return Darwin.log10f(x)
    #elseif canImport(Glibc)
    return Glibc.log10f(x)
    #else
    return Foundation.log10f(x)
    #endif
}

/// Computes the common (base-10) logarithm of x.
///
/// - Parameter x:     floating point value
/// - Returns: If no errors occur, the common (base-10) logarithm of x (log_10(x) or lg(x)) is returned.
/// If a domain error occurs, an implementation-defined value is returned (NaN where supported).
/// If a pole error occurs, -HUGE_VAL, -HUGE_VALF, or -HUGE_VALL is returned.
public func log10(_ x: Double) -> Double {
    #if canImport(Darwin)
    return Darwin.log10(x)
    #elseif canImport(Glibc)
    return Glibc.log10(x)
    #else
    return Foundation.log10(x)
    #endif
}