#if FRB_MATH_FOUNDATION
import Foundation
#endif

#if FRB_MATH_DARWIN
import Darwin.C.math
#endif

#if FRB_MATH_GLIBC
import Glibc
#endif

/// Computes the inverse hyperbolic sine of arg.
///
/// - Parameter double: floating point value representing the area of a hyperbolic sector
/// - Returns: If no errors occur, the inverse hyperbolic sine of arg (sinh^-1(arg), or arsinh(arg)), is returned.
/// If a range error occurs due to underflow, the correct result (after rounding) is returned.
public func asinh(_ double: Double) -> Double {
    #if FRB_MATH_DARWIN
    return Darwin.asinh(double)
    #endif

    #if FRB_MATH_GLIBC

    return Glibc.asinh(double)
    #endif

    #if FRB_MATH_FOUNDATION
    return Foundation.asinh(double)
    #endif
}

/// Computes the inverse hyperbolic sine of arg.
///
/// - Parameter float: floating point value representing the area of a hyperbolic sector
/// - Returns: If no errors occur, the inverse hyperbolic sine of arg (sinh^-1(arg), or arsinh(arg)), is returned.
/// If a range error occurs due to underflow, the correct result (after rounding) is returned.
public func asinh(_ float: Float) -> Float {
    #if FRB_MATH_DARWIN
    return Darwin.asinhf(float)
    #endif

    #if FRB_MATH_GLIBC
    return Glibc.asinhf(float)
    #endif

    #if FRB_MATH_FOUNDATION
    return Foundation.asinhf(float)
    #endif
}
