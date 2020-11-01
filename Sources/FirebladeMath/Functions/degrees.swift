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

@inline(__always)
public func degrees(_ radians: Vec3f) -> Vec3f {
    Vec3f(x: FirebladeMath.degrees(radians.x),
          y: FirebladeMath.degrees(radians.y),
          z: FirebladeMath.degrees(radians.z))
}
