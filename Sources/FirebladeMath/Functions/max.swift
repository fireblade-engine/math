import Foundation

#if canImport(Darwin)
import Darwin
#elseif canImport(Glibc)
import Glibc
#endif

/// Returns the larger of two floating point arguments, treating NaNs as missing data (between a NaN and a numeric value, the numeric value is chosen).
///
/// - Parameters:
///   - x: floating point value
///   - y: floating point value
/// - Returns: If successful, returns the larger of two floating point values. The value returned is exact and does not depend on any rounding modes.
public func max(_ x: Float, _ y: Float) -> Float {
    #if canImport(Darwin)
    return Darwin.fmaxf(x, y)
    #elseif canImport(Glibc)
    return Glibc.fmaxf(x, y)
    #else
    return Foundation.fmaxf(x, y)
    #endif
}

/// Returns the larger of two floating point arguments, treating NaNs as missing data (between a NaN and a numeric value, the numeric value is chosen).
///
/// - Parameters:
///   - x: floating point value
///   - y: floating point value
/// - Returns: If successful, returns the larger of two floating point values. The value returned is exact and does not depend on any rounding modes.
public func max(_ x: Double, _ y: Double) -> Double {
    #if canImport(Darwin)
    return Darwin.fmax(x, y)
    #elseif canImport(Glibc)
    return Glibc.fmax(x, y)
    #else
    return Foundation.fmax(x, y)
    #endif
}