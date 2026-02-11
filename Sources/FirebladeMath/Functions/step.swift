#if FRB_MATH_USE_SIMD
import func simd.step
#endif

/// Returns 0.0 if x < edge, and 1.0 otherwise.
/// - Parameters:
///   - x: source value
///   - edge: edge value
/// - Returns: 0.0 if x < edge, and 1.0 otherwise.
public func step(_ x: Double, _ edge: Double) -> Double {
    #if FRB_MATH_USE_SIMD
    return simd.step(x, edge: edge)
    #else
    return (x < edge) ? 0 : 1
    #endif
}

/// Returns 0.0 if x < edge, and 1.0 otherwise.
/// - Parameters:
///   - x: source value
///   - edge: edge value
/// - Returns: 0.0 if x < edge, and 1.0 otherwise.
public func step(_ x: Float, _ edge: Float) -> Float {
    #if FRB_MATH_USE_SIMD
    return simd.step(x, edge: edge)
    #else
    return (x < edge) ? 0 : 1
    #endif
}
