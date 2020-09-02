/// Flips the normal vector ''n'' to face the direction opposite to the incident vector ''i''
///
/// - Parameters:
///   - n: the normal
///   - i: the incident vector
///   - nref: the reference normal
/// - Returns: one of the following:
///  ''n'' if dot(''i'', ''nref'') < 0.
///  ''-n'' otherwise.
public func faceforward(n: Float, i: Float, nref: Float) -> Float {
    let dot: Float = i * nref
    if dot < 0.0 {
        return n
    } else if dot.isNaN {
        return Float.nan
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
public func faceforward(n: Double, i: Double, nref: Double) -> Double {
    let dot: Double = i * nref
    if dot < 0.0 {
        return n
    } else if dot.isNaN {
        return Double.nan
    } else {
        return -n
    }
}
