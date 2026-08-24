#if canImport(Darwin)
import Darwin
#elseif canImport(Glibc)
import Glibc
#else
import Foundation
#endif

/// Computes the distance between the arguments.
///
/// - Parameters:
///   - x: a float argument.
///   - y: a float argument.
/// - Returns: the distance between the arguments.
@inlinable
public func distance(_ x: Float, _ y: Float) -> Float {
    let diff: Float = x - y
    #if canImport(Darwin)
    return Darwin.fabsf(diff)
    #elseif canImport(Glibc)
    return Glibc.fabsf(diff)
    #else
    return Foundation.fabsf(diff)
    #endif
}

/// Computes the distance between the arguments.
///
/// - Parameters:
///   - x: a double argument.
///   - y: a double argument.
/// - Returns: the distance between the arguments.
@inlinable
public func distance(_ x: Double, _ y: Double) -> Double {
    let diff: Double = x - y
    #if canImport(Darwin)
    return Darwin.fabs(diff)
    #elseif canImport(Glibc)
    return Glibc.fabs(diff)
    #else
    return Foundation.fabs(diff)
    #endif
}
