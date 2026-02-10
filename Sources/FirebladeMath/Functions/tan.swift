import Foundation

#if canImport(Darwin)
import Darwin
#elseif canImport(Glibc)
import Glibc
#endif

/// Computes the tangent of arg (measured in radians).
///
/// - Parameter angleRad:     floating point value representing angle in radians
/// - Returns: If no errors occur, the tangent of arg (tan(arg)) is returned.
/// If a domain error occurs, an implementation-defined value is returned (NaN where supported).
/// If a range error occurs due to underflow, the correct result (after rounding) is returned.
public func tan(_ angleRad: Float) -> Float {
    #if canImport(Darwin)
    return Darwin.tanf(angleRad)
    #elseif canImport(Glibc)
    return Glibc.tanf(angleRad)
    #else
    return Foundation.tanf(angleRad)
    #endif
}

/// Computes the tangent of arg (measured in radians).
///
/// - Parameter angleRad:     floating point value representing angle in radians
/// - Returns: If no errors occur, the tangent of arg (tan(arg)) is returned.
/// If a domain error occurs, an implementation-defined value is returned (NaN where supported).
/// If a range error occurs due to underflow, the correct result (after rounding) is returned.
public func tan(_ angleRad: Double) -> Double {
    #if canImport(Darwin)
    return Darwin.tan(angleRad)
    #elseif canImport(Glibc)
    return Glibc.tan(angleRad)
    #else
    return Foundation.tan(angleRad)
    #endif
}