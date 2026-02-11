import Foundation

#if canImport(Darwin)
import Darwin
#elseif canImport(Glibc)
import Glibc
#endif

/// Computes the largest integer value not greater than x.
///
/// - Parameter x: floating point value
/// - Returns: If no errors occur, the largest integer value not greater than x, that is ⌊x⌋, is returned.
public func floor(_ x: Float) -> Float {
    #if canImport(Darwin)
    return Darwin.floorf(x)
    #elseif canImport(Glibc)
    return Glibc.floorf(x)
    #else
    return Foundation.floorf(x)
    #endif
}

/// Computes the largest integer value not greater than x.
///
/// - Parameter x: floating point value
/// - Returns: If no errors occur, the largest integer value not greater than x, that is ⌊x⌋, is returned.
public func floor(_ x: Double) -> Double {
    #if canImport(Darwin)
    return Darwin.floor(x)
    #elseif canImport(Glibc)
    return Glibc.floor(x)
    #else
    return Foundation.floor(x)
    #endif
}