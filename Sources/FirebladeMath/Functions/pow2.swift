import Foundation

#if canImport(Darwin)
import Darwin
#elseif canImport(Glibc)
import Glibc
#endif
/// Computes the value of base 2 raised to the power exponent.
public func pow2(_ exponent: Float) -> Float {
    #if canImport(Darwin)
    return Darwin.powf(2, exponent)
    #elseif canImport(Glibc)
    return Glibc.powf(2, exponent)
    #else
    return Foundation.powf(2, exponent)
    #endif
}

/// Computes the value of base 2 raised to the power exponent.
public func pow2(_ exponent: Double) -> Double {
    #if canImport(Darwin)
    return Darwin.pow(2, exponent)
    #elseif canImport(Glibc)
    return Glibc.pow(2, exponent)
    #else
    return Foundation.pow(2, exponent)
    #endif
}