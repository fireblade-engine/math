#if FRB_MATH_DARWIN
import Darwin.C.math
#endif

#if FRB_MATH_GLIBC
import Glibc
#endif

/// Computes the natural (base e) logarithm of arg.
///
/// - Parameter float:     floating point value
/// - Returns: If no errors occur, the natural (base-e) logarithm of arg (ln(arg) or log_e(arg)) is returned.
/// If a domain error occurs, an implementation-defined value is returned (NaN where supported).
/// If a pole error occurs, -HUGE_VAL, -HUGE_VALF, or -HUGE_VALL is returned.
public func log(_ float: Float) -> Float {
    #if FRB_MATH_DARWIN
    return Darwin.logf(float)
    #endif

    #if FRB_MATH_GLIBC
    return Glibc.logf(float)
    #endif
}

/// Computes the natural (base e) logarithm of arg.
///
/// - Parameter double:     floating point value
/// - Returns: If no errors occur, the natural (base-e) logarithm of arg (ln(arg) or log_e(arg)) is returned.
/// If a domain error occurs, an implementation-defined value is returned (NaN where supported).
/// If a pole error occurs, -HUGE_VAL, -HUGE_VALF, or -HUGE_VALL is returned.
public func log(_ double: Double) -> Double {
    #if FRB_MATH_DARWIN
    return Darwin.log(double)
    #endif

    #if FRB_MATH_GLIBC
    return Glibc.log(double)
    #endif
}
