#if FRB_MATH_DARWIN
import Darwin.C.math
#endif

#if FRB_MATH_GLIBC
import Glibc
#endif

///  Computes the e (Euler's number, 2.7182818) raised to the given power arg.
///
/// - Parameter float: floating point value
/// - Returns: If no errors occur, the base-e exponential of arg (e^arg) is returned.
/// If a range error due to overflow occurs, +HUGE_VAL, +HUGE_VALF, or +HUGE_VALL is returned.
/// If a range error occurs due to underflow, the correct result (after rounding) is returned.
public func exp(_ power: Float) -> Float {
    #if FRB_MATH_DARWIN
    return Darwin.expf(power)
    #endif

    #if FRB_MATH_GLIBC
    return Glibc.expf(power)
    #endif
}

///  Computes the e (Euler's number, 2.7182818) raised to the given power arg.
///
/// - Parameter double: floating point value
/// - Returns: If no errors occur, the base-e exponential of arg (e^arg) is returned.
/// If a range error due to overflow occurs, +HUGE_VAL, +HUGE_VALF, or +HUGE_VALL is returned.
/// If a range error occurs due to underflow, the correct result (after rounding) is returned.
public func exp(_ power: Double) -> Double {
    #if FRB_MATH_DARWIN
    return Darwin.exp(power)
    #endif

    #if FRB_MATH_GLIBC
    return Glibc.exp(power)
    #endif
}
