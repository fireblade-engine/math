#if canImport(Darwin)
import Darwin.C.math
#elseif canImport(Glibc)
import Glibc
#else
#error("unsupported platform")
#endif

/// Computes the value of base 2 raised to the power exponent.
public func pow2(_ exponent: Float) -> Float {
    #if os(macOS) || os(iOS) || os(tvOS)
    return Darwin.powf(2, exponent)
    #elseif os(Linux)
    return Glibc.powf(2, exponent)
    #endif
}

/// Computes the value of base 2 raised to the power exponent.
public func pow2(_ exponent: Double) -> Double {
    #if os(macOS) || os(iOS) || os(tvOS)
    return Darwin.pow(2, exponent)
    #elseif os(Linux)
    return Glibc.pow(2, exponent)
    #endif
}
