#if canImport(Darwin)
import Darwin.C.math
#elseif canImport(Glibc)
import Glibc
#else
#error("unsupported platform")
#endif

/// Computes the smallest integer value not less than arg.
///
/// - Parameter float:     floating point value
/// - Returns: If no errors occur, the smallest integer value not less than arg, that is ⌈arg⌉, is returned.
public func ceil(_ float: Float32) -> Float32 {
    #if os(macOS) || os(iOS) || os(tvOS)
    return Darwin.ceilf(float)
    #elseif os(Linux)
    return Glibc.ceilf(float)
    #endif
}

/// Computes the smallest integer value not less than arg.
///
/// - Parameter double:     floating point value
/// - Returns: If no errors occur, the smallest integer value not less than arg, that is ⌈arg⌉, is returned.
public func ceil(_ double: Float64) -> Float64 {
    #if os(macOS) || os(iOS) || os(tvOS)
    return Darwin.ceil(double)
    #elseif os(Linux)
    return Glibc.ceil(double)
    #endif
}
