#if FRB_MATH_DARWIN
import Darwin.C.math
#endif

#if FRB_MATH_GLIBC
import Glibc
#endif
/// Computes the value of base 2 raised to the power exponent.
public func pow2(_ exponent: Float) -> Float {
    #if FRB_MATH_DARWIN
    return Darwin.powf(2, exponent)
    #endif

    #if FRB_MATH_GLIBC
    return Glibc.powf(2, exponent)
    #endif
}

/// Computes the value of base 2 raised to the power exponent.
public func pow2(_ exponent: Double) -> Double {
    #if FRB_MATH_DARWIN
    return Darwin.pow(2, exponent)
    #endif

    #if FRB_MATH_GLIBC
    return Glibc.pow(2, exponent)
    #endif
}
