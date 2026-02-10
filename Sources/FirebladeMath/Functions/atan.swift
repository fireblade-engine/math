import Foundation

#if canImport(Darwin)
import Darwin
#elseif canImport(Glibc)
import Glibc
#endif

/// Computes the principal value of the arc tangent of arg.
///
/// - Parameter double: floating point value
/// - Returns: If no errors occur, the arc tangent of arg (arctan(arg)) in the range [-π/2;+π/2] radians, is returned.
/// If a range error occurs due to underflow, the correct result (after rounding) is returned.
public func atan(_ double: Double) -> Double {
    #if canImport(Darwin)
    return Darwin.atan(double)
    #elseif canImport(Glibc)
    return Glibc.atan(double)
    #else
    return Foundation.atan(double)
    #endif
}

/// Computes the principal value of the arc tangent of arg.
///
/// - Parameter float: floating point value
/// - Returns: If no errors occur, the arc tangent of arg (arctan(arg)) in the range [-π/2;+π/2] radians, is returned.
/// If a range error occurs due to underflow, the correct result (after rounding) is returned.
public func atan(_ float: Float) -> Float {
    #if canImport(Darwin)
    return Darwin.atanf(float)
    #elseif canImport(Glibc)
    return Glibc.atanf(float)
    #else
    return Foundation.atanf(float)
    #endif
}
