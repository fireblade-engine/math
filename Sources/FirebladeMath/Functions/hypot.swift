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
public func hypot(_ x: Float32, _ y: Float32) -> Float32 {
    #if os(macOS) || os(iOS) || os(tvOS)
    return Darwin.hypotf(x, y)
    #elseif os(Linux)
    return Glibc.hypotf(x, y)
    #endif
}

/// Returns the hypotenuse of a right-angled triangle whose legs are x and y.
/// - Parameter x: x
/// - Parameter y: y
public func hypot(_ x: Float64, _ y: Float64) -> Float64 {
    #if os(macOS) || os(iOS) || os(tvOS)
    return Darwin.hypot(x, y)
    #elseif os(Linux)
    return Glibc.hypot(x, y)
    #endif
}
