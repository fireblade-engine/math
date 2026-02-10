import Foundation

#if canImport(Darwin)
import Darwin
#elseif canImport(Glibc)
import Glibc
#endif

/// Computes the sine of arg (measured in radians).
///
/// - Parameter float: floating point value representing an angle in radians
/// - Returns: If no errors occur, the sine of arg (sin(arg)) in the range [-1 ; +1], is returned.
/// If a domain error occurs, an implementation-defined value is returned (NaN where supported).
/// If a range error occurs due to underflow, the correct result (after rounding) is returned.
public func sin(_ angleRad: Float) -> Float {
    #if canImport(Darwin)
    return Darwin.sinf(angleRad)
    #elseif canImport(Glibc)
    return Glibc.sinf(angleRad)
    #else
    return Foundation.sinf(angleRad)
    #endif
}

/// Computes the sine of arg (measured in radians).
///
/// - Parameter double: floating point value representing an angle in radians
/// - Returns: If no errors occur, the sine of arg (sin(arg)) in the range [-1 ; +1], is returned.
/// If a domain error occurs, an implementation-defined value is returned (NaN where supported).
/// If a range error occurs due to underflow, the correct result (after rounding) is returned.
public func sin(_ angleRad: Double) -> Double {
    #if canImport(Darwin)
    return Darwin.sin(angleRad)
    #elseif canImport(Glibc)
    return Glibc.sin(angleRad)
    #else
    return Foundation.sin(angleRad)
    #endif
}
