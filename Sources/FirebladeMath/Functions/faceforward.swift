/// Flips the normal vector ''n'' to face the direction opposite to the incident vector ''i''
///
/// - Parameters:
///   - n: the normal
///   - i: the incident vector
///   - nref: the reference normal
/// - Returns: one of the following:
///  ''n'' if dot(''i'', ''nref'') < 0.
///  ''-n'' otherwise.
public func faceforward(n: Float32, i: Float32, nref: Float32) -> Float32 {
    let dot: Float32 = i * nref
    if dot < 0.0 {
        return n
    } else if dot.isNaN {
        return Float32.nan
    } else {
        return -n
    }
}

/// Flips the normal vector ''n'' to face the direction opposite to the incident vector ''i''
///
/// - Parameters:
///   - n: the normal
///   - i: the incident vector
///   - nref: the reference normal
/// - Returns: one of the following:
///  ''n'' if dot(''i'', ''nref'') < 0.
///  ''-n'' otherwise.
public func faceforward(n: Float64, i: Float64, nref: Float64) -> Float64 {
    let dot: Float64 = i * nref
    if dot < 0.0 {
        return n
    } else if dot.isNaN {
        return Float64.nan
    } else {
        return -n
    }
}
