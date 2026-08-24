/// Computes the distance between the arguments.
///
/// - Parameters:
///   - x: a float argument.
///   - y: a float argument.
/// - Returns: the distance between the arguments.
@inlinable
public func distance(_ x: Float, _ y: Float) -> Float {
    let diff: Float = x - y
    return FirebladeMath.abs(diff)
}

/// Computes the distance between the arguments.
///
/// - Parameters:
///   - x: a double argument.
///   - y: a double argument.
/// - Returns: the distance between the arguments.
@inlinable
public func distance(_ x: Double, _ y: Double) -> Double {
    let diff: Double = x - y
    return FirebladeMath.abs(diff)
}
