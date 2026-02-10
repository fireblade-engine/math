import Foundation

#if canImport(Darwin)
import Darwin
#elseif canImport(Glibc)
import Glibc
#endif

/// Returns the smaller of two floating point arguments, treating NaNs as missing data (between a NaN and a numeric value, the numeric value is chosen).
///
/// - Parameters:
///   - x: floating point value
///   - y: floating point value
/// - Returns: If successful, returns the smaller of two floating point values. The value returned is exact and does not depend on any rounding modes.
public func min(_ x: Float, _ y: Float) -> Float {
    #if canImport(Darwin)
    return Darwin.fminf(x, y)
    #elseif canImport(Glibc)
    return Glibc.fminf(x, y)
    #else
    return Foundation.fminf(x, y)
    #endif
}

/// Returns the smaller of two floating point arguments, treating NaNs as missing data (between a NaN and a numeric value, the numeric value is chosen).
///
/// - Parameters:
///   - x: floating point value
///   - y: floating point value
/// - Returns: If successful, returns the smaller of two floating point values. The value returned is exact and does not depend on any rounding modes.
public func min(_ x: Double, _ y: Double) -> Double {
    #if canImport(Darwin)
    return Darwin.fmin(x, y)
    #elseif canImport(Glibc)
    return Glibc.fmin(x, y)
    #else
    return Foundation.fmin(x, y)
    #endif
}