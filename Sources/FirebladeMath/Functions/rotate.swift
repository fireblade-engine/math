/// Rotates a 4D vector around an axis by an angle.
/// - Parameters:
///   - vector: The vector to rotate.
///   - axis: The axis of rotation.
///   - angle: The angle of rotation in radians.
/// - Returns: The rotated vector.
public func rotate(_ vector: Vec4f, _ axis: Vec3f, _ angle: Float) -> Vec4f {
    Mat4x4f(rotation: angle, axis: axis) * vector
}

/// Rotates a 3D vector around an axis by an angle.
/// - Parameters:
///   - vector: The vector to rotate.
///   - axis: The axis of rotation.
///   - angle: The angle of rotation in radians.
/// - Returns: The rotated vector.
public func rotate(_ vector: Vec3f, _ axis: Vec3f, _ angle: Float) -> Vec3f {
    rotate(Vec4f(vector, 1), axis, angle).xyz
}