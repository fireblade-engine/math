import Foundation

#if canImport(Darwin)
import Darwin
#elseif canImport(Glibc)
import Glibc
#endif

///  Computes the base 2 logarithm of arg.
///
/// - Parameter float:     floating point value
/// - Returns: If no errors occur, the base-2 logarithm of arg (log_2(arg) or lb(arg)) is returned.
/// If a domain error occurs, an implementation-defined value is returned (NaN where supported).
/// If a pole error occurs, -HUGE_VAL, -HUGE_VALF, or -HUGE_VALL is returned.
public func log2(_ float: Float) -> Float {
    #if canImport(Darwin)
    return Darwin.log2f(float)
    #elseif canImport(Glibc)
    return Glibc.log2f(float)
    #else
    return Foundation.log2f(float)
    #endif
}

///  Computes the base 2 logarithm of arg.
///
/// - Parameter double:     floating point value
/// - Returns: If no errors occur, the base-2 logarithm of arg (log_2(arg) or lb(arg)) is returned.
/// If a domain error occurs, an implementation-defined value is returned (NaN where supported).
/// If a pole error occurs, -HUGE_VAL, -HUGE_VALF, or -HUGE_VALL is returned.
public func log2(_ double: Double) -> Double {
    #if canImport(Darwin)
    return Darwin.log2(double)
    #elseif canImport(Glibc)
    return Glibc.log2(double)
    #else
    return Foundation.log2(double)
    #endif
}
