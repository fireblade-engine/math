import Foundation

#if canImport(Darwin)
import Darwin
#elseif canImport(Glibc)
import Glibc
#endif

///  The atan2() function computes the principal value of the arc tangent of y/x,
///  using the signs of both arguments to determine the quadrant of the return value.
/// - Parameter y: The y coordinate.
/// - Parameter x: The x coordinate.
/// - Returns: The arc tangent of y/x in radians.
public func atan2(_ y: Double, _ x: Double) -> Double {
    #if canImport(Darwin)
    return Darwin.atan2(y, x)
    #elseif canImport(Glibc)
    return Glibc.atan2(y, x)
    #else
    return Foundation.atan2(y, x)
    #endif
}

///  The atan2() function computes the principal value of the arc tangent of y/x,
///  using the signs of both arguments to determine the quadrant of the return value.
/// - Parameter y: The y coordinate.
/// - Parameter x: The x coordinate.
/// - Returns: The arc tangent of y/x in radians.
public func atan2(_ y: Float, _ x: Float) -> Float {
    #if canImport(Darwin)
    return Darwin.atan2f(y, x)
    #elseif canImport(Glibc)
    return Glibc.atan2f(y, x)
    #else
    return Foundation.atan2f(y, x)
    #endif
}