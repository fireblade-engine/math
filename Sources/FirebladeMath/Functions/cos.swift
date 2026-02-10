import Foundation

#if canImport(Darwin)
import Darwin
#elseif canImport(Glibc)
import Glibc
#endif

/// Computes the cosine of arg (measured in radians).
///
/// - Parameter float: floating point value representing angle in radians
/// - Returns: If no errors occur, the cosine of arg (cos(arg)) in the range [-1 ; +1], is returned.
/// If a domain error occurs, an implementation-defined value is returned (NaN where supported).
/// If a range error occurs due to underflow, the correct result (after rounding) is returned.
public func cos(_ angleRad: Float) -> Float {
    #if canImport(Darwin)
    return Darwin.cosf(angleRad)
    #elseif canImport(Glibc)
    return Glibc.cosf(angleRad)
    #else
    return Foundation.cosf(angleRad)
    #endif
}

/// Computes the cosine of arg (measured in radians).
///
/// - Parameter double: floating point value representing angle in radians
/// - Returns: If no errors occur, the cosine of arg (cos(arg)) in the range [-1 ; +1], is returned.
/// If a domain error occurs, an implementation-defined value is returned (NaN where supported).
/// If a range error occurs due to underflow, the correct result (after rounding) is returned.
public func cos(_ angleRad: Double) -> Double {
    #if canImport(Darwin)
    return Darwin.cos(angleRad)
    #elseif canImport(Glibc)
    return Glibc.cos(angleRad)
    #else
    return Foundation.cos(angleRad)
    #endif
}