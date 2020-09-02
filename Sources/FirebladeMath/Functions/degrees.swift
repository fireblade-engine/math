/// Converts radians to degrees.
///
/// - Parameter radians: an angle in radians.
/// - Returns:  the argument converted to degrees.
public func degrees(_ radians: Float) -> Float { radians * kRadiansToDegree32 }

/// Converts radians to degrees.
///
/// - Parameter radians: an angle in radians.
/// - Returns:  the argument converted to degrees.
public func degrees(_ radians: Double) -> Double { radians * kRadiansToDegree64 }
