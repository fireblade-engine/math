#if canImport(Darwin)
import Darwin.C.math
#elseif canImport(Glibc)
import Glibc
#else
#error("unsupported platform")
#endif
/// Computes the absolute value of a floating point value arg.
///
/// - Parameter float:     floating point value
/// - Returns: If successful, returns the absolute value of arg (|arg|). The value returned is exact and does not depend on any rounding modes.
public func abs(_ float: Float32) -> Float32 {
    fabsf(float)
}

/// Computes the absolute value of a floating point value arg.
///
/// - Parameter double:     floating point value
/// - Returns: If successful, returns the absolute value of arg (|arg|). The value returned is exact and does not depend on any rounding modes.
public func abs(_ double: Float64) -> Float64 {
    #if os(macOS) || os(iOS) || os(tvOS)
    return Darwin.fabs(double)
    #elseif os(Linux)
    return Glibc.fabs(double)
    #endif
}
