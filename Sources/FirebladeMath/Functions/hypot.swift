#if canImport(Darwin)
import Darwin.C.math
#elseif canImport(Glibc)
import Glibc
#else
#error("unsupported platform")
#endif

/// Returns the hypotenuse of a right-angled triangle whose legs are x and y.
/// - Parameter x: x
/// - Parameter y: y
public func hypot(_ x: Float, _ y: Float) -> Float {
    #if os(macOS) || os(iOS) || os(tvOS)
    return Darwin.hypotf(x, y)
    #elseif os(Linux)
    return Glibc.hypotf(x, y)
    #endif
}

/// Returns the hypotenuse of a right-angled triangle whose legs are x and y.
/// - Parameter x: x
/// - Parameter y: y
public func hypot(_ x: Double, _ y: Double) -> Double {
    #if os(macOS) || os(iOS) || os(tvOS)
    return Darwin.hypot(x, y)
    #elseif os(Linux)
    return Glibc.hypot(x, y)
    #endif
}
