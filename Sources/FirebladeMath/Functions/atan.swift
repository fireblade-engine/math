import Foundation

#if canImport(Darwin)
import Darwin
#elseif canImport(Glibc)
import Glibc
#endif

/// Computes the principal value of the arc tangent of x.
///
/// - Parameter x: floating point value
/// - Returns: If no errors occur, the arc tangent of x (arctan(x)) in the range [-π/2;+π/2] radians, is returned.
/// If a range error occurs due to underflow, the correct result (after rounding) is returned.
public func atan(_ x: Double) -> Double {
    #if canImport(Darwin)
    return Darwin.atan(x)
    #elseif canImport(Glibc)
    return Glibc.atan(x)
    #else
    return Foundation.atan(x)
    #endif
}

/// Computes the principal value of the arc tangent of x.
///
/// - Parameter x: floating point value
/// - Returns: If no errors occur, the arc tangent of x (arctan(x)) in the range [-π/2;+π/2] radians, is returned.
/// If a range error occurs due to underflow, the correct result (after rounding) is returned.
public func atan(_ x: Float) -> Float {
    #if canImport(Darwin)
    return Darwin.atanf(x)
    #elseif canImport(Glibc)
    return Glibc.atanf(x)
    #else
    return Foundation.atanf(x)
    #endif
}
