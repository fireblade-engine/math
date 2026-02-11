/// Converts radians to degrees.
///
/// - Parameter radians: an angle in radians.
/// - Returns:  the argument converted to degrees.
public func degrees(_ radians: Float) -> Float {
    radians * kRadiansToDegree32
}

/// Converts radians to degrees.
///
/// - Parameter radians: an angle in radians.
/// - Returns:  the argument converted to degrees.
public func degrees(_ radians: Double) -> Double {
    radians * kRadiansToDegree64
}

/// Converts a vector of radians to degrees.
/// - Parameter radians: A vector of angles in radians.
/// - Returns: A vector of angles in degrees.
@inline(__always)
public func degrees(_ radians: Vec3f) -> Vec3f {
    Vec3f(x: FirebladeMath.degrees(radians.x),
          y: FirebladeMath.degrees(radians.y),
          z: FirebladeMath.degrees(radians.z))
}
