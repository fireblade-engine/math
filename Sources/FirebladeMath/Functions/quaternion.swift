#if FRB_MATH_USE_SIMD
import func simd.simd_quaternion
#endif

/// Creates a quaternion from an angle and an axis.
/// - Parameters:
///   - angle: The angle of rotation in radians.
///   - axis: The axis of rotation.
/// - Returns: The quaternion.
@inlinable
@inline(__always)
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
@inlinable
@inline(__always)
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
@inlinable
public func quaternion(from: SIMD3<Float>, to: SIMD3<Float>) -> Quat4f {
    #if FRB_MATH_USE_SIMD
    return Quat4f(storage: simd.simd_quaternion(from, to))
    #else
    // Mirrors Apple's simd_quaternion(from:to:), so every platform returns the same rotation.
    func reduced(_ from: SIMD3<Float>, _ to: SIMD3<Float>) -> Quat4f {
        // Accurate while `from` and `to` are less than 90 degrees apart.
        let half: SIMD3<Float> = normalize(from + to)
        let imaginary: SIMD3<Float> = cross(from, half)
        return Quat4f(imaginary.x, imaginary.y, imaginary.z, dot(from, half))
    }

    if dot(from, to) >= 0 {
        return reduced(from, to)
    }

    let sum: SIMD3<Float> = normalize(from) + normalize(to)
    if dot(sum, sum) <= 0x1p-46 {
        // Nearly opposite: the axis is underspecified, so pick one orthogonal to `from`
        // the same way simd does, and rotate by pi.
        let absolute = SIMD3<Float>(Swift.abs(from.x), Swift.abs(from.y), Swift.abs(from.z))
        let reference: SIMD3<Float> = if absolute.x <= absolute.y, absolute.x <= absolute.z {
            SIMD3<Float>(1, 0, 0)
        } else if absolute.y <= absolute.z {
            SIMD3<Float>(0, 1, 0)
        } else {
            SIMD3<Float>(0, 0, 1)
        }
        let axis: SIMD3<Float> = normalize(cross(from, reference))
        return Quat4f(axis.x, axis.y, axis.z, 0)
    }

    // More than 90 degrees apart: rotate in two steps through the halfway vector.
    let half: SIMD3<Float> = normalize(sum)
    return multiply(reduced(from, half), reduced(half, to))
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
@inlinable
public func quaternion(from: SIMD3<Double>, to: SIMD3<Double>) -> Quat4d {
    #if FRB_MATH_USE_SIMD
    return Quat4d(storage: simd.simd_quaternion(from, to))
    #else
    // Mirrors Apple's simd_quaternion(from:to:), so every platform returns the same rotation.
    func reduced(_ from: SIMD3<Double>, _ to: SIMD3<Double>) -> Quat4d {
        // Accurate while `from` and `to` are less than 90 degrees apart.
        let half: SIMD3<Double> = normalize(from + to)
        let imaginary: SIMD3<Double> = cross(from, half)
        return Quat4d(imaginary.x, imaginary.y, imaginary.z, dot(from, half))
    }

    if dot(from, to) >= 0 {
        return reduced(from, to)
    }

    let sum: SIMD3<Double> = normalize(from) + normalize(to)
    if dot(sum, sum) <= 0x1p-104 {
        // Nearly opposite: the axis is underspecified, so pick one orthogonal to `from`
        // the same way simd does, and rotate by pi.
        let absolute = SIMD3<Double>(Swift.abs(from.x), Swift.abs(from.y), Swift.abs(from.z))
        let reference: SIMD3<Double> = if absolute.x <= absolute.y, absolute.x <= absolute.z {
            SIMD3<Double>(1, 0, 0)
        } else if absolute.y <= absolute.z {
            SIMD3<Double>(0, 1, 0)
        } else {
            SIMD3<Double>(0, 0, 1)
        }
        let axis: SIMD3<Double> = normalize(cross(from, reference))
        return Quat4d(axis.x, axis.y, axis.z, 0)
    }

    // More than 90 degrees apart: rotate in two steps through the halfway vector.
    let half: SIMD3<Double> = normalize(sum)
    return multiply(reduced(from, half), reduced(half, to))
    #endif
}

/// Creates a quaternion from a 3x3 rotation matrix.
/// - Parameter mat: The 3x3 rotation matrix.
/// - Returns: The quaternion.
@inlinable
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
@inlinable
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
@inlinable
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
@inlinable
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
