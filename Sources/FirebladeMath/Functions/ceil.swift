#if FRB_MATH_FOUNDATION
import Foundation
#endif

#if FRB_MATH_DARWIN
import Darwin.C.math
#endif

#if FRB_MATH_GLIBC
import Glibc
#endif

/// Computes the smallest integer value not less than arg.
///
/// - Parameter float:     floating point value
/// - Returns: If no errors occur, the smallest integer value not less than arg, that is ⌈arg⌉, is returned.
public func ceil(_ float: Float) -> Float {
    #if FRB_MATH_DARWIN
    return Darwin.ceilf(float)
    #endif

    #if FRB_MATH_GLIBC
    return Glibc.ceilf(float)
    #endif

    #if FRB_MATH_FOUNDATION
    return Foundation.ceilf(float)
    #endif
}

/// Computes the smallest integer value not less than arg.
///
/// - Parameter double:     floating point value
/// - Returns: If no errors occur, the smallest integer value not less than arg, that is ⌈arg⌉, is returned.
public func ceil(_ double: Double) -> Double {
    #if FRB_MATH_DARWIN
    return Darwin.ceil(double)
    #endif

    #if FRB_MATH_GLIBC
    return Glibc.ceil(double)
    #endif

    #if FRB_MATH_FOUNDATION
    return Foundation.ceil(double)
    #endif
}
