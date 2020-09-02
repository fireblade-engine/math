#if canImport(Darwin)
import Darwin.C.math
#elseif canImport(Glibc)
import Glibc
#else
#error("unsupported platform")
#endif

/// Computes the sine of arg (measured in radians).
///
/// - Parameter float: floating point value representing an angle in radians
/// - Returns: If no errors occur, the sine of arg (sin(arg)) in the range [-1 ; +1], is returned.
/// If a domain error occurs, an implementation-defined value is returned (NaN where supported).
/// If a range error occurs due to underflow, the correct result (after rounding) is returned.
public func sin(_ angleRad: Float) -> Float {
    #if os(macOS) || os(iOS) || os(tvOS)
    return Darwin.sinf(angleRad)
    #elseif os(Linux)
    return Glibc.sinf(floatAngleRadians)
    #endif
}

/// Computes the sine of arg (measured in radians).
///
/// - Parameter double: floating point value representing an angle in radians
/// - Returns: If no errors occur, the sine of arg (sin(arg)) in the range [-1 ; +1], is returned.
/// If a domain error occurs, an implementation-defined value is returned (NaN where supported).
/// If a range error occurs due to underflow, the correct result (after rounding) is returned.
public func sin(_ angleRad: Double) -> Double {
    #if os(macOS) || os(iOS) || os(tvOS)
    return Darwin.sin(angleRad)
    #elseif os(Linux)
    return Glibc.sin(floatAngleRadians)
    #endif
}
