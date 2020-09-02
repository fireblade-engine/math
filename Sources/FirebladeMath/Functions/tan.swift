#if canImport(Darwin)
import Darwin.C.math
#elseif canImport(Glibc)
import Glibc
#else
#error("unsupported platform")
#endif

/// Computes the tangent of arg (measured in radians).
///
/// - Parameter angleRad:     floating point value representing angle in radians
/// - Returns: If no errors occur, the tangent of arg (tan(arg)) is returned.
/// If a domain error occurs, an implementation-defined value is returned (NaN where supported).
/// If a range error occurs due to underflow, the correct result (after rounding) is returned.
public func tan(_ angleRad: Float) -> Float {
    tanf(angleRad)
}

/// Computes the tangent of arg (measured in radians).
///
/// - Parameter angleRad:     floating point value representing angle in radians
/// - Returns: If no errors occur, the tangent of arg (tan(arg)) is returned.
/// If a domain error occurs, an implementation-defined value is returned (NaN where supported).
/// If a range error occurs due to underflow, the correct result (after rounding) is returned.
public func tan(_ angleRad: Double) -> Double {
    #if os(macOS) || os(iOS) || os(tvOS)
    return Darwin.tan(angleRad)
    #elseif os(Linux)
    return Glibc.tan(double)
    #endif
}
