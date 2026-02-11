import Foundation

#if canImport(Darwin)
import Darwin
#elseif canImport(Glibc)
import Glibc
#endif

/// Computes the absolute value of a floating point value x.
///
/// - Parameter x: floating point value
/// - Returns: If successful, returns the absolute value of x (|x|). The value returned is exact and does not depend on any rounding modes.
public func abs(_ x: Float) -> Float {
    fabsf(x)
}

/// Computes the absolute value of a floating point value x.
///
/// - Parameter x: floating point value
/// - Returns: If successful, returns the absolute value of x (|x|). The value returned is exact and does not depend on any rounding modes.
public func abs(_ x: Double) -> Double {
    #if canImport(Darwin)
    return Darwin.fabs(x)
    #elseif canImport(Glibc)
    return Glibc.fabs(x)
    #else
    return Foundation.fabs(x)
    #endif
}
