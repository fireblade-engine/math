#if FRB_MATH_DARWIN
import Darwin.C.math
#endif

#if FRB_MATH_GLIBC
import Glibc
#endif

/// Returns the smaller of two floating point arguments, treating NaNs as missing data (between a NaN and a numeric value, the numeric value is chosen).
///
/// - Parameters:
///   - x: floating point value
///   - y: floating point value
/// - Returns: If successful, returns the smaller of two floating point values. The value returned is exact and does not depend on any rounding modes.
public func min(_ x: Float, _ y: Float) -> Float {
    #if FRB_MATH_DARWIN
    return Darwin.fminf(x, y)
    #endif

    #if FRB_MATH_GLIBC
    return Glibc.fminf(x, y)
    #endif
}

/// Returns the smaller of two floating point arguments, treating NaNs as missing data (between a NaN and a numeric value, the numeric value is chosen).
///
/// - Parameters:
///   - x: floating point value
///   - y: floating point value
/// - Returns: If successful, returns the smaller of two floating point values. The value returned is exact and does not depend on any rounding modes.
public func min(_ x: Double, _ y: Double) -> Double {
    #if FRB_MATH_DARWIN
    return Darwin.fmin(x, y)
    #endif

    #if FRB_MATH_GLIBC
    return Glibc.fmin(x, y)
    #endif
}
