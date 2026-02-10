import Foundation

#if canImport(Darwin)
import Darwin
#elseif canImport(Glibc)
import Glibc
#endif

/// Computes the principal value of the arc cosine of arg.
///
/// - Parameter float: floating point value
/// - Returns: If no errors occur, the arc cosine of arg (arccos(arg)) in the range [0 ; π], is returned.
///               If a domain error occurs, an implementation-defined value is returned (NaN where supported).
///                If a range error occurs due to underflow, the correct result (after rounding) is returned.
public func acos(_ float: Float) -> Float {
    #if canImport(Darwin)
    return Darwin.acosf(float)
    #elseif canImport(Glibc)
    return Glibc.acosf(float)
    #else
    return Foundation.acosf(float)
    #endif
}

/// Computes the principal value of the arc cosine of arg.
///
/// - Parameter double: floating point value
/// - Returns: If no errors occur, the arc cosine of arg (arccos(arg)) in the range [0 ; π], is returned.
///               If a domain error occurs, an implementation-defined value is returned (NaN where supported).
///                If a range error occurs due to underflow, the correct result (after rounding) is returned.
public func acos(_ double: Double) -> Double {
    #if canImport(Darwin)
    return Darwin.acos(double)
    #elseif canImport(Glibc)
    return Glibc.acos(double)
    #else
    return Foundation.acos(double)
    #endif
}