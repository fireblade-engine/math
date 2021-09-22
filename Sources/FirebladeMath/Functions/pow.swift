#if FRB_MATH_FOUNDATION
import Foundation
#endif

#if FRB_MATH_DARWIN
import Darwin.C.math
#endif

#if FRB_MATH_GLIBC
import Glibc
#endif

/// Computes the value of base raised to the power exponent.
///
/// - Parameters:
///   - base:     base as floating point value
///   - exponent: exponent as floating point value
/// - Returns: If no errors occur, base raised to the power of exponent (base^exponent) is returned.
/// If a domain error occurs, an implementation-defined value is returned (NaN where supported).
/// If a pole error or a range error due to overflow occurs, ±HUGE_VAL, ±HUGE_VALF, or ±HUGE_VALL is returned.
/// If a range error occurs due to underflow, the correct result (after rounding) is returned.
public func pow(_ base: Float, _ exponent: Float) -> Float {
    #if FRB_MATH_DARWIN
    return Darwin.powf(base, exponent)
    #endif

    #if FRB_MATH_GLIBC
    return Glibc.powf(base, exponent)
    #endif

    #if FRB_MATH_FOUNDATION
    return Foundation.powf(base, exponent)
    #endif
}

/// Computes the value of base raised to the power exponent.
///
/// - Parameters:
///   - base:     base as floating point value
///   - exponent: exponent as floating point value
/// - Returns: If no errors occur, base raised to the power of exponent (base^exponent) is returned.
/// If a domain error occurs, an implementation-defined value is returned (NaN where supported).
/// If a pole error or a range error due to overflow occurs, ±HUGE_VAL, ±HUGE_VALF, or ±HUGE_VALL is returned.
/// If a range error occurs due to underflow, the correct result (after rounding) is returned.
public func pow(_ base: Double, _ exponent: Double) -> Double {
    #if FRB_MATH_DARWIN
    return Darwin.pow(base, exponent)
    #endif

    #if FRB_MATH_GLIBC
    return Glibc.pow(base, exponent)
    #endif

    #if FRB_MATH_FOUNDATION
    return Foundation.pow(base, exponent)
    #endif
}
