import Foundation

#if canImport(Darwin)
import Darwin
#elseif canImport(Glibc)
import Glibc
#endif

/// Returns the hypotenuse of a right-angled triangle whose legs are x and y.
/// - Parameter x: x
/// - Parameter y: y
public func hypot(_ x: Float, _ y: Float) -> Float {
    #if canImport(Darwin)
    return Darwin.hypotf(x, y)
    #elseif canImport(Glibc)
    return Glibc.hypotf(x, y)
    #else
    return Foundation.hypotf(x, y)
    #endif
}

/// Returns the hypotenuse of a right-angled triangle whose legs are x and y.
/// - Parameter x: x
/// - Parameter y: y
public func hypot(_ x: Double, _ y: Double) -> Double {
    #if canImport(Darwin)
    return Darwin.hypot(x, y)
    #elseif canImport(Glibc)
    return Glibc.hypot(x, y)
    #else
    return Foundation.hypot(x, y)
    #endif
}