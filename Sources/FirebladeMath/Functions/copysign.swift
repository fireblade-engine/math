#if FRB_MATH_FOUNDATION
import Foundation
#endif

#if FRB_MATH_DARWIN
import Darwin.C.math
#endif

#if FRB_MATH_GLIBC
import Glibc
#endif

/// Composes a floating point value with the magnitude of x and the sign of y.
///
/// - Parameters:
///   - x:     floating point value
///   - y:     floating point value
/// - Returns: If no errors occur, the floating point value with the magnitude of x and the sign of y is returned.
///            If x is NaN, then NaN with the sign of y is returned.
///            If y is -0, the result is only negative if the implementation supports the signed zero consistently in
///            arithmetic operations.
public func copysign(_ x: Double, _ y: Double) -> Double {
    #if FRB_MATH_DARWIN
    return Darwin.copysign(x, y)
    #endif

    #if FRB_MATH_GLIBC
    return Glibc.copysign(x, y)
    #endif

    #if FRB_MATH_FOUNDATION
    return Foundation.copysign(x, y)
    #endif
}

/// Composes a floating point value with the magnitude of x and the sign of y.
///
/// - Parameters:
///   - x:     floating point value
///   - y:     floating point value
/// - Returns: If no errors occur, the floating point value with the magnitude of x and the sign of y is returned.
///            If x is NaN, then NaN with the sign of y is returned.
///            If y is -0, the result is only negative if the implementation supports the signed zero consistently in
///            arithmetic operations.
public func copysign(_ x: Float, _ y: Float) -> Float {
    #if FRB_MATH_DARWIN
    return Darwin.copysignf(x, y)
    #endif

    #if FRB_MATH_GLIBC
    return Glibc.copysignf(x, y)
    #endif

    #if FRB_MATH_FOUNDATION
    return Foundation.copysignf(x, y)
    #endif
}
