#if FRB_MATH_USE_SIMD
import func simd.simd_length
#endif

/// Returns the length of vector x.
///
/// - Parameter x: x
/// - Returns: the distance between the argument and the origin.
@inlinable
public func length(_ x: SIMD2<Double>) -> Double {
    #if FRB_MATH_USE_SIMD
    return simd_length(x)
    #else
    let sq = x.x * x.x + x.y * x.y
    return sqrt(sq)
    #endif
}

/// Returns the length of vector x.
///
/// - Parameter x: x
/// - Returns: the distance between the argument and the origin.
@inlinable
public func length(_ x: SIMD2<Float>) -> Float {
    #if FRB_MATH_USE_SIMD
    return simd_length(x)
    #else
    let sq = x.x * x.x + x.y * x.y
    return sqrt(sq)
    #endif
}

/// Returns the length of vector x.
///
/// - Parameter x: x
/// - Returns: the distance between the argument and the origin.
@inlinable
public func length(_ x: SIMD3<Double>) -> Double {
    #if FRB_MATH_USE_SIMD
    return simd_length(x)
    #else
    let sq = x.x * x.x + x.y * x.y + x.z * x.z
    return sqrt(sq)
    #endif
}

/// Returns the length of vector x.
///
/// - Parameter x: x
/// - Returns: the distance between the argument and the origin.
@inlinable
public func length(_ x: SIMD3<Float>) -> Float {
    #if FRB_MATH_USE_SIMD
    return simd_length(x)
    #else
    let sq = x.x * x.x + x.y * x.y + x.z * x.z
    return sqrt(sq)
    #endif
}

/// Returns the length of vector x.
///
/// - Parameter x: x
/// - Returns: the distance between the argument and the origin.
@inlinable
public func length(_ x: SIMD4<Double>) -> Double {
    #if FRB_MATH_USE_SIMD
    return simd_length(x)
    #else
    let sq = x.x * x.x + x.y * x.y + x.z * x.z + x.w * x.w
    return sqrt(sq)
    #endif
}

/// Returns the length of vector x.
///
/// - Parameter x: x
/// - Returns: the distance between the argument and the origin.
@inlinable
public func length(_ x: SIMD4<Float>) -> Float {
    #if FRB_MATH_USE_SIMD
    return simd_length(x)
    #else
    let sq = x.x * x.x + x.y * x.y + x.z * x.z + x.w * x.w
    return sqrt(sq)
    #endif
}

/// Returns the length of the quaternion.
///
/// - Parameter x: x
/// - Returns: the distance between the argument and the origin.
@inlinable
public func length(_ x: Quat4f) -> Float {
    #if FRB_MATH_USE_SIMD
    return simd_length(x.storage)
    #else
    let sq = x.x * x.x + x.y * x.y + x.z * x.z + x.w * x.w
    return sqrt(sq)
    #endif
}

/// Returns the length of the quaternion.
///
/// - Parameter x: x
/// - Returns: the distance between the argument and the origin.
@inlinable
public func length(_ x: Quat4d) -> Double {
    #if FRB_MATH_USE_SIMD
    return simd_length(x.storage)
    #else
    let sq = x.x * x.x + x.y * x.y + x.z * x.z + x.w * x.w
    return sqrt(sq)
    #endif
}
