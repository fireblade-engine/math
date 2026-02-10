import Foundation

#if canImport(Darwin)
import Darwin
#elseif canImport(Glibc)
import Glibc
#endif

/// Computes the floating-point remainder of the division operation x/y.
/// The floating-point remainder of the division operation x/y calculated by this function is exactly the value x - n*y, where n is x/y with its fractional part truncated.
/// The returned value has the same sign as x and is less or equal to y in magnitude.
/// - Parameters:
///   - x:     floating point value
///   - y:     floating point value
/// - Returns: If successful, returns the floating-point remainder of the division x/y as defined above.
/// If a domain error occurs, an implementation-defined value is returned (NaN where supported).
/// If a range error occurs due to underflow, the correct result (after rounding) is returned.
public func mod(_ x: Float, _ y: Float) -> Float {
    #if canImport(Darwin)
    return Darwin.fmodf(x, y)
    #elseif canImport(Glibc)
    return Glibc.fmodf(x, y)
    #else
    return Foundation.fmodf(x, y)
    #endif
}

/// Computes the floating-point remainder of the division operation x/y.
/// The floating-point remainder of the division operation x/y calculated by this function is exactly the value x - n*y, where n is x/y with its fractional part truncated.
/// The returned value has the same sign as x and is less or equal to y in magnitude.
/// - Parameters:
///   - x:     floating point value
///   - y:     floating point value
/// - Returns: If successful, returns the floating-point remainder of the division x/y as defined above.
/// If a domain error occurs, an implementation-defined value is returned (NaN where supported).
/// If a range error occurs due to underflow, the correct result (after rounding) is returned.
public func mod(_ x: Double, _ y: Double) -> Double {
    #if canImport(Darwin)
    return Darwin.fmod(x, y)
    #elseif canImport(Glibc)
    return Glibc.fmod(x, y)
    #else
    return Foundation.fmod(x, y)
    #endif
}
