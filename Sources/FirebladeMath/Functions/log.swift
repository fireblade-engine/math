import Foundation

#if canImport(Darwin)
import Darwin
#elseif canImport(Glibc)
import Glibc
#endif

/// Computes the natural (base e) logarithm of x.
///
/// - Parameter x:     floating point value
/// - Returns: If no errors occur, the natural (base-e) logarithm of x (ln(x) or log_e(x)) is returned.
/// If a domain error occurs, an implementation-defined value is returned (NaN where supported).
/// If a pole error occurs, -HUGE_VAL, -HUGE_VALF, or -HUGE_VALL is returned.
public func log(_ x: Float) -> Float {
    #if canImport(Darwin)
    return Darwin.logf(x)
    #elseif canImport(Glibc)
    return Glibc.logf(x)
    #else
    return Foundation.logf(x)
    #endif
}

/// Computes the natural (base e) logarithm of x.
///
/// - Parameter x:     floating point value
/// - Returns: If no errors occur, the natural (base-e) logarithm of x (ln(x) or log_e(x)) is returned.
/// If a domain error occurs, an implementation-defined value is returned (NaN where supported).
/// If a pole error occurs, -HUGE_VAL, -HUGE_VALF, or -HUGE_VALL is returned.
public func log(_ x: Double) -> Double {
    #if canImport(Darwin)
    return Darwin.log(x)
    #elseif canImport(Glibc)
    return Glibc.log(x)
    #else
    return Foundation.log(x)
    #endif
}
