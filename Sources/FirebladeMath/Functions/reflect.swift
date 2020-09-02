/// Reflects the incident vector ''i'' with respect to the normal vector ''n''.
/// This function is equivalent to `i - 2*dot(n, i)*n`.
///
/// - Parameters:
///   - i: the incident vector.
///   - n: the normal, must be normalized to achieve the desired result.
/// - Returns: the reflection vector.
public func reflect(_ i: Float, _ n: Float) -> Float { i - 2 * (n * i) * n }

/// Reflects the incident vector ''i'' with respect to the normal vector ''n''.
/// This function is equivalent to `i - 2*dot(n, i)*n`.
///
/// - Parameters:
///   - i: the incident vector.
///   - n: the normal, must be normalized to achieve the desired result.
/// - Returns: the reflection vector.
public func reflect(_ i: Double, _ n: Double) -> Double { i - 2 * (n * i) * n }
