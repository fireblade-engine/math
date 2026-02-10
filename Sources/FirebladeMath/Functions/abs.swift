import Foundation

#if canImport(Darwin)
import Darwin
#elseif canImport(Glibc)
import Glibc
#endif

/// Computes the absolute value of a floating point value arg.
///
/// - Parameter float:     floating point value
/// - Returns: If successful, returns the absolute value of arg (|arg|). The value returned is exact and does not depend on any rounding modes.
public func abs(_ float: Float) -> Float {
    fabsf(float)
}

/// Computes the absolute value of a floating point value arg.
///
/// - Parameter double:     floating point value
/// - Returns: If successful, returns the absolute value of arg (|arg|). The value returned is exact and does not depend on any rounding modes.
public func abs(_ double: Double) -> Double {
    #if canImport(Darwin)
    return Darwin.fabs(double)
    #elseif canImport(Glibc)
    return Glibc.fabs(double)
    #else
    return Foundation.fabs(double)
    #endif
}
