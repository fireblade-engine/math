#if FRB_MATH_USE_SIMD
import func simd.simd_quaternion
#endif

/// Creates a quaternion from an angle and an axis.
/// - Parameters:
///   - angle: The angle of rotation in radians.
///   - axis: The axis of rotation.
/// - Returns: The quaternion.
public func quaternion(angle: Float, axis: SIMD3<Float>) -> Quat4f {
    #if FRB_MATH_USE_SIMD
    return Quat4f(storage: simd_quaternion(angle, axis))
    #else
    return Quat4f(Vec4f(sin(angle / 2.0) * axis, cos(angle / 2.0)))
    #endif
}

/// Creates a quaternion from an angle and an axis.
/// - Parameters:
///   - angle: The angle of rotation in radians.
///   - axis: The axis of rotation.
/// - Returns: The quaternion.
public func quaternion(angle: Double, axis: SIMD3<Double>) -> Quat4d {
    #if FRB_MATH_USE_SIMD
    return Quat4d(storage: simd_quaternion(angle, axis))
    #else
    return Quat4d(Vec4d(sin(angle / 2.0) * axis, cos(angle / 2.0)))
    #endif
}

/// Construct a quaternion that rotates from one vector to another.
///
/// The rotation axis is `simd_cross(from, to)`. If `from` and
/// `to` point in opposite directions (to within machine precision), an
/// arbitrary rotation axis is chosen, and the angle is pi radians.
///
/// - Parameters:
///   - from: A normalized three-element vector.
///   - to: A normalized three-element vector.
/// - Returns: The quaternion.
public func quaternion(from: SIMD3<Float>, to: SIMD3<Float>) -> Quat4f {
    #if FRB_MATH_USE_SIMD
    return Quat4f(storage: simd.simd_quaternion(from, to))
    #else
    let half = normalize(from + to)
    let img = cross(from, half)
    let real = dot(from, half)
    return Quat4f(img.x, img.y, img.z, real)
    #endif
}

/// Construct a quaternion that rotates from one vector to another.
///
/// The rotation axis is `simd_cross(from, to)`. If `from` and
/// `to` point in opposite directions (to within machine precision), an
/// arbitrary rotation axis is chosen, and the angle is pi radians.
///
/// - Parameters:
///   - from: A normalized three-element vector.
///   - to: A normalized three-element vector.
/// - Returns: The quaternion.
public func quaternion(from: SIMD3<Double>, to: SIMD3<Double>) -> Quat4d {
    #if FRB_MATH_USE_SIMD
    return Quat4d(storage: simd.simd_quaternion(from, to))
    #else
    let half = normalize(from + to)
    let img = cross(from, half)
    let real = dot(from, half)
    return Quat4d(img.x, img.y, img.z, real)
    #endif
}

/// Creates a quaternion from a 3x3 rotation matrix.
/// - Parameter mat: The 3x3 rotation matrix.
/// - Returns: The quaternion.
public func quaternion(matrix mat: Mat3x3f) -> Quat4f {
    #if FRB_MATH_USE_SIMD
    return Quat4f(storage: simd_quaternion(mat.storage))
    #else
    let trace = mat[0, 0] + mat[1, 1] + mat[2, 2]
    if trace >= 0.0 {
        let r = 2 * sqrt(1 + trace)
        let rinv = 1 / r
        return Quat4f(rinv * (mat[1, 2] - mat[2, 1]),
                      rinv * (mat[2, 0] - mat[0, 2]),
                      rinv * (mat[0, 1] - mat[1, 0]),
                      r / 4)
    } else if mat[0, 0] >= mat[1, 1], mat[0, 0] >= mat[2, 2] {
        let r = 2 * sqrt(1 - mat[1, 1] - mat[2, 2] + mat[0, 0])
        let rinv = 1 / r
        return Quat4f(r / 4,
                      rinv * (mat[0, 1] + mat[1, 0]),
                      rinv * (mat[0, 2] + mat[2, 0]),
                      rinv * (mat[1, 2] - mat[2, 1]))
    } else if mat[1, 1] >= mat[2, 2] {
        let r = 2 * sqrt(1 - mat[0, 0] - mat[2, 2] + mat[1, 1])
        let rinv = 1 / r
        return Quat4f(rinv * (mat[0, 1] + mat[1, 0]),
                      r / 4,
                      rinv * (mat[1, 2] + mat[2, 1]),
                      rinv * (mat[2, 0] - mat[0, 2]))
    } else {
        let r = 2 * sqrt(1 - mat[0, 0] - mat[1, 1] + mat[2, 2])
        let rinv = 1 / r
        return Quat4f(rinv * (mat[0, 2] + mat[2, 0]),
                      rinv * (mat[1, 2] + mat[2, 1]),
                      r / 4,
                      rinv * (mat[0, 1] - mat[1, 0]))
    }
    #endif
}

/// Creates a quaternion from a 3x3 rotation matrix.
/// - Parameter mat: The 3x3 rotation matrix.
/// - Returns: The quaternion.
public func quaternion(matrix mat: Mat3x3d) -> Quat4d {
    #if FRB_MATH_USE_SIMD
    return Quat4d(storage: simd_quaternion(mat.storage))
    #else
    let trace = mat[0, 0] + mat[1, 1] + mat[2, 2]
    if trace >= 0.0 {
        let r = 2 * sqrt(1 + trace)
        let rinv = 1 / r
        return Quat4d(rinv * (mat[1, 2] - mat[2, 1]),
                      rinv * (mat[2, 0] - mat[0, 2]),
                      rinv * (mat[0, 1] - mat[1, 0]),
                      r / 4)
    } else if mat[0, 0] >= mat[1, 1], mat[0, 0] >= mat[2, 2] {
        let r = 2 * sqrt(1 - mat[1, 1] - mat[2, 2] + mat[0, 0])
        let rinv = 1 / r
        return Quat4d(r / 4,
                      rinv * (mat[0, 1] + mat[1, 0]),
                      rinv * (mat[0, 2] + mat[2, 0]),
                      rinv * (mat[1, 2] - mat[2, 1]))
    } else if mat[1, 1] >= mat[2, 2] {
        let r = 2 * sqrt(1 - mat[0, 0] - mat[2, 2] + mat[1, 1])
        let rinv = 1 / r
        return Quat4d(rinv * (mat[0, 1] + mat[1, 0]),
                      r / 4,
                      rinv * (mat[1, 2] + mat[2, 1]),
                      rinv * (mat[2, 0] - mat[0, 2]))
    } else {
        let r = 2 * sqrt(1 - mat[0, 0] - mat[1, 1] + mat[2, 2])
        let rinv = 1 / r
        return Quat4d(rinv * (mat[0, 2] + mat[2, 0]),
                      rinv * (mat[1, 2] + mat[2, 1]),
                      r / 4,
                      rinv * (mat[0, 1] - mat[1, 0]))
    }
    #endif
}

/// Creates a quaternion from a 4x4 rotation matrix.
/// - Parameter mat: The 4x4 rotation matrix.
/// - Returns: The quaternion.
public func quaternion(matrix mat: Mat4x4f) -> Quat4f {
    #if FRB_MATH_USE_SIMD
    return Quat4f(storage: simd_quaternion(mat.storage))
    #else

    let trace = mat[0, 0] + mat[1, 1] + mat[2, 2]
    if trace >= 0.0 {
        let r = 2 * sqrt(1 + trace)
        let rinv = 1 / r
        return Quat4f(rinv * (mat[1, 2] - mat[2, 1]),
                      rinv * (mat[2, 0] - mat[0, 2]),
                      rinv * (mat[0, 1] - mat[1, 0]),
                      r / 4)
    } else if mat[0, 0] >= mat[1, 1], mat[0, 0] >= mat[2, 2] {
        let r = 2 * sqrt(1 - mat[1, 1] - mat[2, 2] + mat[0, 0])
        let rinv = 1 / r
        return Quat4f(r / 4,
                      rinv * (mat[0, 1] + mat[1, 0]),
                      rinv * (mat[0, 2] + mat[2, 0]),
                      rinv * (mat[1, 2] - mat[2, 1]))
    } else if mat[1, 1] >= mat[2, 2] {
        let r = 2 * sqrt(1 - mat[0, 0] - mat[2, 2] + mat[1, 1])
        let rinv = 1 / r
        return Quat4f(rinv * (mat[0, 1] + mat[1, 0]),
                      r / 4,
                      rinv * (mat[1, 2] + mat[2, 1]),
                      rinv * (mat[2, 0] - mat[0, 2]))
    } else {
        let r = 2 * sqrt(1 - mat[0, 0] - mat[1, 1] + mat[2, 2])
        let rinv = 1 / r
        return Quat4f(rinv * (mat[0, 2] + mat[2, 0]),
                      rinv * (mat[1, 2] + mat[2, 1]),
                      r / 4,
                      rinv * (mat[0, 1] - mat[1, 0]))
    }
    #endif
}

/// Creates a quaternion from a 4x4 rotation matrix.
/// - Parameter mat: The 4x4 rotation matrix.
/// - Returns: The quaternion.
public func quaternion(matrix mat: Mat4x4d) -> Quat4d {
    #if FRB_MATH_USE_SIMD
    return Quat4d(storage: simd_quaternion(mat.storage))
    #else

    let trace = mat[0, 0] + mat[1, 1] + mat[2, 2]
    if trace >= 0.0 {
        let r = 2 * sqrt(1 + trace)
        let rinv = 1 / r
        return Quat4d(rinv * (mat[1, 2] - mat[2, 1]),
                      rinv * (mat[2, 0] - mat[0, 2]),
                      rinv * (mat[0, 1] - mat[1, 0]),
                      r / 4)
    } else if mat[0, 0] >= mat[1, 1], mat[0, 0] >= mat[2, 2] {
        let r = 2 * sqrt(1 - mat[1, 1] - mat[2, 2] + mat[0, 0])
        let rinv = 1 / r
        return Quat4d(r / 4,
                      rinv * (mat[0, 1] + mat[1, 0]),
                      rinv * (mat[0, 2] + mat[2, 0]),
                      rinv * (mat[1, 2] - mat[2, 1]))
    } else if mat[1, 1] >= mat[2, 2] {
        let r = 2 * sqrt(1 - mat[0, 0] - mat[2, 2] + mat[1, 1])
        let rinv = 1 / r
        return Quat4d(rinv * (mat[0, 1] + mat[1, 0]),
                      r / 4,
                      rinv * (mat[1, 2] + mat[2, 1]),
                      rinv * (mat[2, 0] - mat[0, 2]))
    } else {
        let r = 2 * sqrt(1 - mat[0, 0] - mat[1, 1] + mat[2, 2])
        let rinv = 1 / r
        return Quat4d(rinv * (mat[0, 2] + mat[2, 0]),
                      rinv * (mat[1, 2] + mat[2, 1]),
                      r / 4,
                      rinv * (mat[0, 1] - mat[1, 0]))
    }
    #endif
}