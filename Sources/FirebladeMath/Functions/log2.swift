import Foundation

#if canImport(Darwin)
import Darwin
#elseif canImport(Glibc)
import Glibc
#endif

///  Computes the base 2 logarithm of x.
///
/// - Parameter x:     floating point value
/// - Returns: If no errors occur, the base-2 logarithm of x (log_2(x) or lb(x)) is returned.
/// If a domain error occurs, an implementation-defined value is returned (NaN where supported).
/// If a pole error occurs, -HUGE_VAL, -HUGE_VALF, or -HUGE_VALL is returned.
public func log2(_ x: Float) -> Float {
    #if canImport(Darwin)
    return Darwin.log2f(x)
    #elseif canImport(Glibc)
    return Glibc.log2f(x)
    #else
    return Foundation.log2f(x)
    #endif
}

///  Computes the base 2 logarithm of x.
///
/// - Parameter x:     floating point value
/// - Returns: If no errors occur, the base-2 logarithm of x (log_2(x) or lb(x)) is returned.
/// If a domain error occurs, an implementation-defined value is returned (NaN where supported).
/// If a pole error occurs, -HUGE_VAL, -HUGE_VALF, or -HUGE_VALL is returned.
public func log2(_ x: Double) -> Double {
    #if canImport(Darwin)
    return Darwin.log2(x)
    #elseif canImport(Glibc)
    return Glibc.log2(x)
    #else
    return Foundation.log2(x)
    #endif
}