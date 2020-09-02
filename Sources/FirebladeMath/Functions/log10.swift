#if canImport(Darwin)
import Darwin.C.math
#elseif canImport(Glibc)
import Glibc
#else
#error("unsupported platform")
#endif
/// Computes the common (base-10) logarithm of arg.
///
/// - Parameter float:     floating point value
/// - Returns: If no errors occur, the common (base-10) logarithm of arg (log_10(arg) or lg(arg)) is returned.
/// If a domain error occurs, an implementation-defined value is returned (NaN where supported).
/// If a pole error occurs, -HUGE_VAL, -HUGE_VALF, or -HUGE_VALL is returned.
public func log10(_ float: Float) -> Float {
    #if os(macOS) || os(iOS) || os(tvOS)
    return Darwin.log10f(float)
    #elseif os(Linux)
    return Glibc.log10f(float)
    #endif
}

/// Computes the common (base-10) logarithm of arg.
///
/// - Parameter double:     floating point value
/// - Returns: If no errors occur, the common (base-10) logarithm of arg (log_10(arg) or lg(arg)) is returned.
/// If a domain error occurs, an implementation-defined value is returned (NaN where supported).
/// If a pole error occurs, -HUGE_VAL, -HUGE_VALF, or -HUGE_VALL is returned.
public func log10(_ double: Double) -> Double {
    #if os(macOS) || os(iOS) || os(tvOS)
    return Darwin.log10(double)
    #elseif os(Linux)
    return Glibc.log10(double)
    #endif
}
