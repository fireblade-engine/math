import Foundation

#if canImport(Darwin)
import Darwin
#elseif canImport(Glibc)
import Glibc
#endif

/// Computes the smallest integer value not less than arg.
///
/// - Parameter float:     floating point value
/// - Returns: If no errors occur, the smallest integer value not less than arg, that is ⌈arg⌉, is returned.
public func ceil(_ float: Float) -> Float {
    #if canImport(Darwin)
    return Darwin.ceilf(float)
    #elseif canImport(Glibc)
    return Glibc.ceilf(float)
    #else
    return Foundation.ceilf(float)
    #endif
}

/// Computes the smallest integer value not less than arg.
///
/// - Parameter double:     floating point value
/// - Returns: If no errors occur, the smallest integer value not less than arg, that is ⌈arg⌉, is returned.
public func ceil(_ double: Double) -> Double {
    #if canImport(Darwin)
    return Darwin.ceil(double)
    #elseif canImport(Glibc)
    return Glibc.ceil(double)
    #else
    return Foundation.ceil(double)
    #endif
}