#if canImport(Darwin)
import Darwin.C.math
#elseif canImport(Glibc)
import Glibc
#else
#error("unsupported platform")
#endif

/// Returns the smaller of two floating point arguments, treating NaNs as missing data (between a NaN and a numeric value, the numeric value is chosen).
///
/// - Parameters:
///   - x: floating point value
///   - y: floating point value
/// - Returns: If successful, returns the smaller of two floating point values. The value returned is exact and does not depend on any rounding modes.
public func min(_ x: Float, _ y: Float) -> Float {
    #if os(macOS) || os(iOS) || os(tvOS)
    return Darwin.fminf(x, y)
    #elseif os(Linux)
    return Glibc.fminf(x, y)
    #endif
}

/// Returns the smaller of two floating point arguments, treating NaNs as missing data (between a NaN and a numeric value, the numeric value is chosen).
///
/// - Parameters:
///   - x: floating point value
///   - y: floating point value
/// - Returns: If successful, returns the smaller of two floating point values. The value returned is exact and does not depend on any rounding modes.
public func min(_ x: Double, _ y: Double) -> Double {
    #if os(macOS) || os(iOS) || os(tvOS)
    return Darwin.fmin(x, y)
    #elseif os(Linux)
    return Glibc.fmin(x, y)
    #endif
}
