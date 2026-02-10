import Foundation

#if canImport(Darwin)
import Darwin
#elseif canImport(Glibc)
import Glibc
#endif

/// Computes the hyperbolic tangent of arg.
///
/// - Parameter float:     floating point value representing a hyperbolic angle
/// - Returns: If no errors occur, the hyperbolic tangent of arg (tanh(arg), or (e^arg*-e^-arg)/(e^arg*+e^-arg)) is returned.
/// If a range error occurs due to underflow, the correct result (after rounding) is returned.
public func tanh(_ float: Float) -> Float {
    #if canImport(Darwin)
    return Darwin.tanhf(float)
    #elseif canImport(Glibc)
    return Glibc.tanhf(float)
    #else
    return Foundation.tanhf(float)
    #endif
}

/// Computes the hyperbolic tangent of arg.
///
/// - Parameter double:     floating point value representing a hyperbolic angle
/// - Returns: If no errors occur, the hyperbolic tangent of arg (tanh(arg), or (e^arg*-e^-arg)/(e^arg*+e^-arg)) is returned.
/// If a range error occurs due to underflow, the correct result (after rounding) is returned.
public func tanh(_ double: Double) -> Double {
    #if canImport(Darwin)
    return Darwin.tanh(double)
    #elseif canImport(Glibc)
    return Glibc.tanh(double)
    #else
    return Foundation.tanh(double)
    #endif
}
