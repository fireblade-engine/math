#if canImport(Darwin)
import Darwin.C.math
#elseif canImport(Glibc)
import Glibc
#else
#error("unsupported platform")
#endif
///  The atan2() function computes the principal value of the arc tangent of y/x,
///  using the signs of both arguments to determine the quadrant of the return value.
/// - Parameter y: y
/// - Parameter x: x
public func atan2(_ y: Double, _ x: Double) -> Double {
    #if os(macOS) || os(iOS) || os(tvOS)
    return Darwin.atan2(y, x)
    #elseif os(Linux)
    return Glibc.atan2(y, x)
    #endif
}

///  The atan2() function computes the principal value of the arc tangent of y/x,
///  using the signs of both arguments to determine the quadrant of the return value.
/// - Parameter y: y
/// - Parameter x: x
public func atan2(_ y: Float, _ x: Float) -> Float {
    #if os(macOS) || os(iOS) || os(tvOS)
    return Darwin.atan2f(y, x)
    #elseif os(Linux)
    return Glibc.atan2f(y, x)
    #endif
}
