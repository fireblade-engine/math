/// Refracts the incident vector ''i'' with respect to the normal vector ''n''
/// using the ratio of indices of refraction ''eta''.
///
/// - Parameters:
///   - i: the incident vector, must be normalized to achieve the desired result.
///   - n: the normal, must be normalized to achieve the desired result.
///   - eta: the ratio of indices of refration.
/// - Returns: the refraction vector.
public func refract(_ i: Float, _ n: Float, _ eta: Float) -> Float {
    let nTi: Float = n * i
    let frac: Float = 1 - eta * eta * (1 - nTi * nTi)
    if frac < 0 {
        return Float(0.0)
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
public func refract(_ i: Double, _ n: Double, _ eta: Double) -> Double {
    let nTi: Double = n * i
    let frac: Double = 1 - eta * eta * (1 - nTi * nTi)
    if frac < 0 {
        return Double(0.0)
    } else {
        return eta * i - (eta * nTi + sqrt(frac)) * n
    }
}
