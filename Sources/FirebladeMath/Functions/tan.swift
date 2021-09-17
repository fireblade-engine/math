#if FRB_MATH_FOUNDATION
import Foundation
#endif

#if FRB_MATH_DARWIN
import Darwin.C.math
#endif

#if FRB_MATH_GLIBC
import Glibc
#endif

/// Computes the tangent of arg (measured in radians).
///
/// - Parameter angleRad:     floating point value representing angle in radians
/// - Returns: If no errors occur, the tangent of arg (tan(arg)) is returned.
/// If a domain error occurs, an implementation-defined value is returned (NaN where supported).
/// If a range error occurs due to underflow, the correct result (after rounding) is returned.
public func tan(_ angleRad: Float) -> Float {
    #if FRB_MATH_FOUNDATION
    Foundation.tanf(angleRad)
    #else
    tanf(angleRad)
    #endif
}

/// Computes the tangent of arg (measured in radians).
///
/// - Parameter angleRad:     floating point value representing angle in radians
/// - Returns: If no errors occur, the tangent of arg (tan(arg)) is returned.
/// If a domain error occurs, an implementation-defined value is returned (NaN where supported).
/// If a range error occurs due to underflow, the correct result (after rounding) is returned.
public func tan(_ angleRad: Double) -> Double {
    #if FRB_MATH_DARWIN
    return Darwin.tan(angleRad)
    #endif

    #if FRB_MATH_GLIBC
    return Glibc.tan(angleRad)
    #endif

    #if FRB_MATH_FOUNDATION
    return Foundation.tan(angleRad)
    #endif
}
