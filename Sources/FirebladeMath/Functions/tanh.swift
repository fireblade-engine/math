import Foundation

#if canImport(Darwin)
import Darwin
#elseif canImport(Glibc)
import Glibc
#endif

/// Computes the hyperbolic tangent of x.
///
/// - Parameter x:     floating point value representing a hyperbolic angle
/// - Returns: If no errors occur, the hyperbolic tangent of x (tanh(x), or (e^x*-e^-x)/(e^x*+e^-x)) is returned.
/// If a range error occurs due to underflow, the correct result (after rounding) is returned.
public func tanh(_ x: Float) -> Float {
    #if canImport(Darwin)
    return Darwin.tanhf(x)
    #elseif canImport(Glibc)
    return Glibc.tanhf(x)
    #else
    return Foundation.tanhf(x)
    #endif
}

/// Computes the hyperbolic tangent of x.
///
/// - Parameter x:     floating point value representing a hyperbolic angle
/// - Returns: If no errors occur, the hyperbolic tangent of x (tanh(x), or (e^x*-e^-x)/(e^x*+e^-x)) is returned.
/// If a range error occurs due to underflow, the correct result (after rounding) is returned.
public func tanh(_ x: Double) -> Double {
    #if canImport(Darwin)
    return Darwin.tanh(x)
    #elseif canImport(Glibc)
    return Glibc.tanh(x)
    #else
    return Foundation.tanh(x)
    #endif
}
