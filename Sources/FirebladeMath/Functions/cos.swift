#if FRB_MATH_DARWIN
import Darwin.C.math
#endif

#if FRB_MATH_GLIBC
import Glibc
#endif

/// Computes the cosine of arg (measured in radians).
///
/// - Parameter float: floating point value representing angle in radians
/// - Returns: If no errors occur, the cosine of arg (cos(arg)) in the range [-1 ; +1], is returned.
/// If a domain error occurs, an implementation-defined value is returned (NaN where supported).
/// If a range error occurs due to underflow, the correct result (after rounding) is returned.
public func cos(_ angleRad: Float) -> Float {
    #if FRB_MATH_DARWIN
    return Darwin.cosf(angleRad)
    #endif

    #if FRB_MATH_GLIBC
    return Glibc.cosf(angleRad)
    #endif
}

/// Computes the cosine of arg (measured in radians).
///
/// - Parameter double: floating point value representing angle in radians
/// - Returns: If no errors occur, the cosine of arg (cos(arg)) in the range [-1 ; +1], is returned.
/// If a domain error occurs, an implementation-defined value is returned (NaN where supported).
/// If a range error occurs due to underflow, the correct result (after rounding) is returned.
public func cos(_ angleRad: Double) -> Double {
    #if FRB_MATH_DARWIN
    return Darwin.cos(angleRad)
    #endif

    #if FRB_MATH_GLIBC
    return Glibc.cos(angleRad)
    #endif
}
