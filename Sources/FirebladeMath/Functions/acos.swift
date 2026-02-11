import Foundation

#if canImport(Darwin)
import Darwin
#elseif canImport(Glibc)
import Glibc
#endif

/// Computes the principal value of the arc cosine of x.
///
/// - Parameter x: floating point value
/// - Returns: If no errors occur, the arc cosine of x (arccos(x)) in the range [0 ; π], is returned.
///               If a domain error occurs, an implementation-defined value is returned (NaN where supported).
///                If a range error occurs due to underflow, the correct result (after rounding) is returned.
public func acos(_ x: Float) -> Float {
    #if canImport(Darwin)
    return Darwin.acosf(x)
    #elseif canImport(Glibc)
    return Glibc.acosf(x)
    #else
    return Foundation.acosf(x)
    #endif
}

/// Computes the principal value of the arc cosine of x.
///
/// - Parameter x: floating point value
/// - Returns: If no errors occur, the arc cosine of x (arccos(x)) in the range [0 ; π], is returned.
///               If a domain error occurs, an implementation-defined value is returned (NaN where supported).
///                If a range error occurs due to underflow, the correct result (after rounding) is returned.
public func acos(_ x: Double) -> Double {
    #if canImport(Darwin)
    return Darwin.acos(x)
    #elseif canImport(Glibc)
    return Glibc.acos(x)
    #else
    return Foundation.acos(x)
    #endif
}
