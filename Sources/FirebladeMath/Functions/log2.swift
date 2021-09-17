#if FRB_MATH_FOUNDATION
import Foundation
#endif

#if FRB_MATH_DARWIN
import Darwin.C.math
#endif

#if FRB_MATH_GLIBC
import Glibc
#endif

///  Computes the base 2 logarithm of arg.
///
/// - Parameter float:     floating point value
/// - Returns: If no errors occur, the base-2 logarithm of arg (log_2(arg) or lb(arg)) is returned.
/// If a domain error occurs, an implementation-defined value is returned (NaN where supported).
/// If a pole error occurs, -HUGE_VAL, -HUGE_VALF, or -HUGE_VALL is returned.
public func log2(_ float: Float) -> Float {
    #if FRB_MATH_DARWIN
    return Darwin.log2f(float)
    #endif

    #if FRB_MATH_GLIBC
    return Glibc.log2f(float)
    #endif

    #if FRB_MATH_FOUNDATION
    return Foundation.log2f(float)
    #endif
}

///  Computes the base 2 logarithm of arg.
///
/// - Parameter double:     floating point value
/// - Returns: If no errors occur, the base-2 logarithm of arg (log_2(arg) or lb(arg)) is returned.
/// If a domain error occurs, an implementation-defined value is returned (NaN where supported).
/// If a pole error occurs, -HUGE_VAL, -HUGE_VALF, or -HUGE_VALL is returned.
public func log2(_ double: Double) -> Double {
    #if FRB_MATH_DARWIN
    return Darwin.log2(double)
    #endif

    #if FRB_MATH_GLIBC
    return Glibc.log2(double)
    #endif

    #if FRB_MATH_FOUNDATION
    return Foundation.log2(double)
    #endif
}
