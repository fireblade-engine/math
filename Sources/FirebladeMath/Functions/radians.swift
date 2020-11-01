/// Converts degress to radians.
///
/// - Parameter degrees: an angle (in degrees)
/// - Returns: the argument converted to radians.
public func radians(_ degrees: Float) -> Float { degrees * kDegreeToRadians32 }

/// Converts degress to radians.
///
/// - Parameter degrees: an angle (in degrees)
/// - Returns: the argument converted to radians.
public func radians(_ degrees: Double) -> Double { degrees * kDegreeToRadians64 }

@inline(__always)
public func radians(_ degrees: Vec3f) -> Vec3f {
    Vec3f(x: FirebladeMath.radians(degrees.x),
          y: FirebladeMath.radians(degrees.y),
          z: FirebladeMath.radians(degrees.z))
}
