#if FRB_MATH_DARWIN
import Darwin.C.math
#endif

#if FRB_MATH_GLIBC
import Glibc
#endif

/// Computes square root of arg.
///
/// - Parameter float:     floating point value
/// - Returns: If no errors occur, square root of arg (√arg), is returned.
/// If a domain error occurs, an implementation-defined value is returned (NaN where supported).
/// If a range error occurs due to underflow, the correct result (after rounding) is returned.
public func sqrt(_ float: Float) -> Float {
    #if FRB_MATH_DARWIN
    return Darwin.sqrtf(float)
    #endif

    #if FRB_MATH_GLIBC
    return Glibc.sqrtf(float)
    #endif
}

/// Computes square root of arg.
///
/// - Parameter double:     floating point value
/// - Returns: If no errors occur, square root of arg (√arg), is returned.
/// If a domain error occurs, an implementation-defined value is returned (NaN where supported).
/// If a range error occurs due to underflow, the correct result (after rounding) is returned.
public func sqrt(_ double: Double) -> Double {
    #if FRB_MATH_DARWIN
    return Darwin.sqrt(double)
    #endif

    #if FRB_MATH_GLIBC
    return Glibc.sqrt(double)
    #endif
}
