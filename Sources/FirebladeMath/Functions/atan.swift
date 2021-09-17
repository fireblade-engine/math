#if FRB_MATH_FOUNDATION
import Foundation
#endif

#if FRB_MATH_DARWIN
import Darwin.C.math
#endif

#if FRB_MATH_GLIBC
import Glibc
#endif

/// Computes the principal value of the arc tangent of arg.
///
/// - Parameter double: floating point value
/// - Returns: If no errors occur, the arc tangent of arg (arctan(arg)) in the range [-π/2;+π/2] radians, is returned.
/// If a range error occurs due to underflow, the correct result (after rounding) is returned.
public func atan(_ double: Double) -> Double {
    #if FRB_MATH_DARWIN
    return Darwin.atan(double)
    #endif

    #if FRB_MATH_GLIBC
    return Glibc.atan(double)
    #endif

    #if FRB_MATH_FOUNDATION
    return Foundation.atan(double)
    #endif
}

/// Computes the principal value of the arc tangent of arg.
///
/// - Parameter float: floating point value
/// - Returns: If no errors occur, the arc tangent of arg (arctan(arg)) in the range [-π/2;+π/2] radians, is returned.
/// If a range error occurs due to underflow, the correct result (after rounding) is returned.
public func atan(_ float: Float) -> Float {
    #if FRB_MATH_DARWIN
    return Darwin.atanf(float)
    #endif

    #if FRB_MATH_GLIBC
    return Glibc.atanf(float)
    #endif

    #if FRB_MATH_FOUNDATION
    return Foundation.atanf(float)
    #endif
}
