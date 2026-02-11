/// Multiplies a scalar by a quaternion.
/// - Parameters:
///   - lhs: The scalar value.
///   - rhs: The quaternion.
/// - Returns: The scaled quaternion.
public func * (lhs: Float, rhs: Quat4f) -> Quat4f {
    multiply(lhs, rhs)
}

/// Multiplies a quaternion by a scalar.
/// - Parameters:
///   - lhs: The quaternion.
///   - rhs: The scalar value.
/// - Returns: The scaled quaternion.
public func * (lhs: Quat4f, rhs: Float) -> Quat4f {
    multiply(lhs, rhs)
}

/// Returns the product of two quaternions.
/// - Parameters:
///   - lhs: The left-hand side quaternion.
///   - rhs: The right-hand side quaternion.
/// - Returns: The product of the two quaternions.
public func * (lhs: Quat4f, rhs: Quat4f) -> Quat4f {
    multiply(lhs, rhs)
}

/// Returns a vector rotated by a quaternion.
/// - Parameters:
///   - lhs: The quaternion.
///   - rhs: The vector to rotate.
/// - Returns: The rotated vector.
public func * (lhs: Quat4f, rhs: Vec3f) -> Vec3f {
    act(lhs, rhs)
}

/// Multiplies two quaternions and assigns the result to the left-hand side.
/// - Parameters:
///   - lhs: The left-hand side quaternion to be modified.
///   - rhs: The right-hand side quaternion.
public func *= (lhs: inout Quat4f, rhs: Quat4f) {
    lhs = multiply(lhs, rhs)
}

/// Adds two quaternions component-wise.
/// - Parameters:
///   - lhs: The left-hand side quaternion.
///   - rhs: The right-hand side quaternion.
/// - Returns: The sum of the two quaternions.
public func + (lhs: Quat4f, rhs: Quat4f) -> Quat4f {
    add(lhs, rhs)
}

/// Subtracts the right-hand side quaternion from the left-hand side quaternion component-wise.
/// - Parameters:
///   - lhs: The left-hand side quaternion.
///   - rhs: The right-hand side quaternion.
/// - Returns: The difference of the two quaternions.
public func - (lhs: Quat4f, rhs: Quat4f) -> Quat4f {
    subtract(lhs, rhs)
}

/// Multiplies a scalar by a quaternion.
/// - Parameters:
///   - lhs: The scalar value.
///   - rhs: The quaternion.
/// - Returns: The scaled quaternion.
public func * (lhs: Double, rhs: Quat4d) -> Quat4d {
    multiply(lhs, rhs)
}

/// Multiplies a quaternion by a scalar.
/// - Parameters:
///   - lhs: The quaternion.
///   - rhs: The scalar value.
/// - Returns: The scaled quaternion.
public func * (lhs: Quat4d, rhs: Double) -> Quat4d {
    multiply(lhs, rhs)
}

/// Returns the product of two quaternions.
/// - Parameters:
///   - lhs: The left-hand side quaternion.
///   - rhs: The right-hand side quaternion.
/// - Returns: The product of the two quaternions.
public func * (lhs: Quat4d, rhs: Quat4d) -> Quat4d {
    multiply(lhs, rhs)
}

/// Returns a vector rotated by a quaternion.
/// - Parameters:
///   - lhs: The quaternion.
///   - rhs: The vector to rotate.
/// - Returns: The rotated vector.
public func * (lhs: Quat4d, rhs: Vec3d) -> Vec3d {
    act(lhs, rhs)
}

/// Multiplies two quaternions and assigns the result to the left-hand side.
/// - Parameters:
///   - lhs: The left-hand side quaternion to be modified.
///   - rhs: The right-hand side quaternion.
public func *= (lhs: inout Quat4d, rhs: Quat4d) {
    lhs = multiply(lhs, rhs)
}

/// Adds two quaternions component-wise.
/// - Parameters:
///   - lhs: The left-hand side quaternion.
///   - rhs: The right-hand side quaternion.
/// - Returns: The sum of the two quaternions.
public func + (lhs: Quat4d, rhs: Quat4d) -> Quat4d {
    add(lhs, rhs)
}

/// Subtracts the right-hand side quaternion from the left-hand side quaternion component-wise.
/// - Parameters:
///   - lhs: The left-hand side quaternion.
///   - rhs: The right-hand side quaternion.
/// - Returns: The difference of the two quaternions.
public func - (lhs: Quat4d, rhs: Quat4d) -> Quat4d {
    subtract(lhs, rhs)
}
