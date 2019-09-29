#if canImport(Darwin)
import Darwin.C.math
#elseif canImport(Glibc)
import Glibc
#else
#error("unsupported platform")
#endif

/// Computes the tangent of arg (measured in radians).
///
/// - Parameter float:     floating point value representing angle in radians
/// - Returns: If no errors occur, the tangent of arg (tan(arg)) is returned.
/// If a domain error occurs, an implementation-defined value is returned (NaN where supported).
/// If a range error occurs due to underflow, the correct result (after rounding) is returned.
public func tan(_ float: Float32) -> Float32 {
    return tanf(float)
}

/// Computes the tangent of arg (measured in radians).
///
/// - Parameter double:     floating point value representing angle in radians
/// - Returns: If no errors occur, the tangent of arg (tan(arg)) is returned.
/// If a domain error occurs, an implementation-defined value is returned (NaN where supported).
/// If a range error occurs due to underflow, the correct result (after rounding) is returned.
public func tan(_ double: Float64) -> Float64 {
    #if os(macOS) || os(iOS) || os(tvOS)
    return Darwin.tan(double)
    #elseif os(Linux)
    return Glibc.tan(double)
    #endif
}
