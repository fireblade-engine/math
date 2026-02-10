import Foundation

#if canImport(Darwin)
import Darwin
#elseif canImport(Glibc)
import Glibc
#endif

/// Computes the natural (base e) logarithm of arg.
///
/// - Parameter float:     floating point value
/// - Returns: If no errors occur, the natural (base-e) logarithm of arg (ln(arg) or log_e(arg)) is returned.
/// If a domain error occurs, an implementation-defined value is returned (NaN where supported).
/// If a pole error occurs, -HUGE_VAL, -HUGE_VALF, or -HUGE_VALL is returned.
public func log(_ float: Float) -> Float {
    #if canImport(Darwin)
    return Darwin.logf(float)
    #elseif canImport(Glibc)
    return Glibc.logf(float)
    #else
    return Foundation.logf(float)
    #endif
}

/// Computes the natural (base e) logarithm of arg.
///
/// - Parameter double:     floating point value
/// - Returns: If no errors occur, the natural (base-e) logarithm of arg (ln(arg) or log_e(arg)) is returned.
/// If a domain error occurs, an implementation-defined value is returned (NaN where supported).
/// If a pole error occurs, -HUGE_VAL, -HUGE_VALF, or -HUGE_VALL is returned.
public func log(_ double: Double) -> Double {
    #if canImport(Darwin)
    return Darwin.log(double)
    #elseif canImport(Glibc)
    return Glibc.log(double)
    #else
    return Foundation.log(double)
    #endif
}
