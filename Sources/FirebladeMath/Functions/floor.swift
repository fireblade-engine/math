import Foundation

#if canImport(Darwin)
import Darwin
#elseif canImport(Glibc)
import Glibc
#endif

/// Computes the largest integer value not greater than arg.
///
/// - Parameter float: floating point value
/// - Returns: If no errors occur, the largest integer value not greater than arg, that is ⌊arg⌋, is returned.
public func floor(_ float: Float) -> Float {
    #if canImport(Darwin)
    return Darwin.floorf(float)
    #elseif canImport(Glibc)
    return Glibc.floorf(float)
    #else
    return Foundation.floorf(float)
    #endif
}

/// Computes the largest integer value not greater than arg.
///
/// - Parameter double: floating point value
/// - Returns: If no errors occur, the largest integer value not greater than arg, that is ⌊arg⌋, is returned.
public func floor(_ double: Double) -> Double {
    #if canImport(Darwin)
    return Darwin.floor(double)
    #elseif canImport(Glibc)
    return Glibc.floor(double)
    #else
    return Foundation.floor(double)
    #endif
}
