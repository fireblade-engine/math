import Foundation

#if canImport(Darwin)
import Darwin
#elseif canImport(Glibc)
import Glibc
#endif

/// Computes the smallest integer value not less than x.
///
/// - Parameter x:     floating point value
/// - Returns: If no errors occur, the smallest integer value not less than x, that is ⌈x⌉, is returned.
public func ceil(_ x: Float) -> Float {
    #if canImport(Darwin)
    return Darwin.ceilf(x)
    #elseif canImport(Glibc)
    return Glibc.ceilf(x)
    #else
    return Foundation.ceilf(x)
    #endif
}

/// Computes the smallest integer value not less than x.
///
/// - Parameter x:     floating point value
/// - Returns: If no errors occur, the smallest integer value not less than x, that is ⌈x⌉, is returned.
public func ceil(_ x: Double) -> Double {
    #if canImport(Darwin)
    return Darwin.ceil(x)
    #elseif canImport(Glibc)
    return Glibc.ceil(x)
    #else
    return Foundation.ceil(x)
    #endif
}
