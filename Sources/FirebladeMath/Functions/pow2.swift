#if canImport(Darwin)
import Darwin.C.math
#elseif canImport(Glibc)
import Glibc
#else
#error("unsupported platform")
#endif

/// Computes the value of base 2 raised to the power exponent.
public func pow2(_ exponent: Float32) -> Float32 {
    #if os(macOS) || os(iOS) || os(tvOS)
    return Darwin.powf(2, exponent)
    #elseif os(Linux)
    return Glibc.powf(2, exponent)
    #endif
}

/// Computes the value of base 2 raised to the power exponent.
public func pow2(_ exponent: Float64) -> Float64 {
    #if os(macOS) || os(iOS) || os(tvOS)
    return Darwin.pow(2, exponent)
    #elseif os(Linux)
    return Glibc.pow(2, exponent)
    #endif
}
