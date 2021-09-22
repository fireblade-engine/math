#if FRB_MATH_FOUNDATION
import Foundation
#endif

#if FRB_MATH_DARWIN
import Darwin.C.math
#endif

#if FRB_MATH_GLIBC
import Glibc
#endif

/// Returns the larger of two floating point arguments, treating NaNs as missing data (between a NaN and a numeric value, the numeric value is chosen).
///
/// - Parameters:
///   - x: floating point value
///   - y: floating point value
/// - Returns: If successful, returns the larger of two floating point values. The value returned is exact and does not depend on any rounding modes.
public func max(_ x: Float, _ y: Float) -> Float {
    #if FRB_MATH_DARWIN
    return Darwin.fmaxf(x, y)
    #endif

    #if FRB_MATH_GLIBC
    return Glibc.fmaxf(x, y)
    #endif

    #if FRB_MATH_FOUNDATION
    return Foundation.fmaxf(x, y)
    #endif
}

/// Returns the larger of two floating point arguments, treating NaNs as missing data (between a NaN and a numeric value, the numeric value is chosen).
///
/// - Parameters:
///   - x: floating point value
///   - y: floating point value
/// - Returns: If successful, returns the larger of two floating point values. The value returned is exact and does not depend on any rounding modes.
public func max(_ x: Double, _ y: Double) -> Double {
    fmax(x, y)
}
