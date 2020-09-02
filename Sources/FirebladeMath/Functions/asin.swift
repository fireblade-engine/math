#if FRB_MATH_DARWIN
import Darwin.C.math
#endif

#if FRB_MATH_GLIBC
import Glibc
#endif

/// Computes the principal values of the arc sine of arg.
///
/// - Parameter double:     floating point value
/// - Returns: If no errors occur, the arc sine of arg (arcsin(arg)) in the range [-π/2;+π/2], is returned.
/// If a domain error occurs, an implementation-defined value is returned (NaN where supported).
/// If a range error occurs due to underflow, the correct result (after rounding) is returned.
public func asin(_ double: Double) -> Double {
    #if FRB_MATH_DARWIN
    return Darwin.asin(double)
    #endif

    #if FRB_MATH_GLIBC
    return Glibc.asin(double)
    #endif
}

/// Computes the principal values of the arc sine of arg.
///
/// - Parameter float:     floating point value
/// - Returns: If no errors occur, the arc sine of arg (arcsin(arg)) in the range [-π/2;+π/2], is returned.
/// If a domain error occurs, an implementation-defined value is returned (NaN where supported).
/// If a range error occurs due to underflow, the correct result (after rounding) is returned.
public func asin(_ float: Float) -> Float {
    #if FRB_MATH_DARWIN
    return Darwin.asinf(float)
    #endif

    #if FRB_MATH_GLIBC
    return Glibc.asinf(float)
    #endif
}
