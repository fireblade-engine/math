#if canImport(Darwin)
import Darwin.C.math
#elseif canImport(Glibc)
import Glibc
#else
#error("unsupported platform")
#endif

///  Computes the base 2 logarithm of arg.
///
/// - Parameter float:     floating point value
/// - Returns: If no errors occur, the base-2 logarithm of arg (log_2(arg) or lb(arg)) is returned.
/// If a domain error occurs, an implementation-defined value is returned (NaN where supported).
/// If a pole error occurs, -HUGE_VAL, -HUGE_VALF, or -HUGE_VALL is returned.
public func log2(_ float: Float) -> Float {
    #if os(macOS) || os(iOS) || os(tvOS)
    return Darwin.log2f(float)
    #elseif os(Linux)
    return Glibc.log2f(float)
    #endif
}

///  Computes the base 2 logarithm of arg.
///
/// - Parameter double:     floating point value
/// - Returns: If no errors occur, the base-2 logarithm of arg (log_2(arg) or lb(arg)) is returned.
/// If a domain error occurs, an implementation-defined value is returned (NaN where supported).
/// If a pole error occurs, -HUGE_VAL, -HUGE_VALF, or -HUGE_VALL is returned.
public func log2(_ double: Double) -> Double {
    #if os(macOS) || os(iOS) || os(tvOS)
    return Darwin.log2(double)
    #elseif os(Linux)
    return Glibc.log2(double)
    #endif
}
