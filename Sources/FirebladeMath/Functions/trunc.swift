#if FRB_MATH_DARWIN
import Darwin.C.math
#endif

#if FRB_MATH_GLIBC
import Glibc
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
    #if FRB_MATH_DARWIN
    return Darwin.trunc(double)
    #endif

    #if FRB_MATH_GLIBC
    return Glibc.trunc(double)
    #endif
}
