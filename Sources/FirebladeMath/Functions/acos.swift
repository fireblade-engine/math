#if canImport(Darwin)
import Darwin.C.math
#elseif canImport(Glibc)
import Glibc
#else
#error("unsupported platform")
#endif

/// Computes the principal value of the arc cosine of arg.
///
/// - Parameter float: floating point value
/// - Returns: If no errors occur, the arc cosine of arg (arccos(arg)) in the range [0 ; π], is returned.
///               If a domain error occurs, an implementation-defined value is returned (NaN where supported).
///                If a range error occurs due to underflow, the correct result (after rounding) is returned.
public func acos(_ float: Float32) -> Float32 {
    #if os(macOS) || os(iOS) || os(tvOS)
    return Darwin.acosf(float)
    #elseif os(Linux)
    return Glibc.acosf(float)
    #endif
}
