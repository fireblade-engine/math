#if canImport(Darwin)
import Darwin.C.math
#elseif canImport(Glibc)
import Glibc
#else
#error("unsupported platform")
#endif

/// Computes the nearest integer not greater in magnitude than arg.
///
/// - Parameter float:     floating point value
/// - Returns: If no errors occur, the nearest integer value not greater in magnitude than arg (in other words, arg rounded towards zero), is returned.
public func trunc(_ float: Float) -> Float {
    truncf(float)
}

/// Computes the nearest integer not greater in magnitude than arg.
///
/// - Parameter double:     floating point value
/// - Returns: If no errors occur, the nearest integer value not greater in magnitude than arg (in other words, arg rounded towards zero), is returned.
public func trunc(_ double: Double) -> Double {
    #if os(macOS) || os(iOS) || os(tvOS)
    return Darwin.trunc(double)
    #elseif os(Linux)
    return Glibc.trunc(double)
    #endif
}
