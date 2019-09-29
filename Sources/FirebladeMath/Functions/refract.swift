/// Refracts the incident vector ''i'' with respect to the normal vector ''n''
/// using the ratio of indices of refraction ''eta''.
///
/// - Parameters:
///   - i: the incident vector, must be normalized to achieve the desired result.
///   - n: the normal, must be normalized to achieve the desired result.
///   - eta: the ratio of indices of refration.
/// - Returns: the refraction vector.
public func refract(_ i: Float32, _ n: Float32, _ eta: Float32) -> Float32 {
    let nTi: Float32 = n * i
    let frac: Float32 = 1 - eta * eta * (1 - nTi * nTi)
    if frac < 0 {
        return Float32(0.0)
    } else {
        return eta * i - (eta * nTi + sqrt(frac)) * n
    }
}

/// Refracts the incident vector ''i'' with respect to the normal vector ''n''
/// using the ratio of indices of refraction ''eta''.
///
/// - Parameters:
///   - i: the incident vector, must be normalized to achieve the desired result.
///   - n: the normal, must be normalized to achieve the desired result.
///   - eta: the ratio of indices of refration.
/// - Returns: the refraction vector.
public func refract(_ i: Float64, _ n: Float64, _ eta: Float64) -> Float64 {
    let nTi: Float64 = n * i
    let frac: Float64 = 1 - eta * eta * (1 - nTi * nTi)
    if frac < 0 {
        return Float64(0.0)
    } else {
        return eta * i - (eta * nTi + sqrt(frac)) * n
    }
}
