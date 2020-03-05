/// Reflects the incident vector ''i'' with respect to the normal vector ''n''.
/// This function is equivalent to `i - 2*dot(n, i)*n`.
///
/// - Parameters:
///   - i: the incident vector.
///   - n: the normal, must be normalized to achieve the desired result.
/// - Returns: the reflection vector.
public func reflect(_ i: Float32, _ n: Float32) -> Float32 { i - 2 * (n * i) * n }

/// Reflects the incident vector ''i'' with respect to the normal vector ''n''.
/// This function is equivalent to `i - 2*dot(n, i)*n`.
///
/// - Parameters:
///   - i: the incident vector.
///   - n: the normal, must be normalized to achieve the desired result.
/// - Returns: the reflection vector.
public func reflect(_ i: Float64, _ n: Float64) -> Float64 { i - 2 * (n * i) * n }
