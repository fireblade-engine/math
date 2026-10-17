/// Computes the adjugate of a 3x3 matrix.
/// - Parameter inMat: The input matrix.
/// - Returns: The adjugate of the input matrix.
@inlinable
public func adjugate(_ inMat: Mat3x3f) -> Mat3x3f {
    var out = Mat3x3f.identity

    out[0, 0] = inMat[1, 1] * inMat[2, 2] - inMat[1, 2] * inMat[2, 1]
    out[0, 1] = -(inMat[0, 1] * inMat[2, 2] - inMat[0, 2] * inMat[2, 1])
    out[0, 2] = inMat[0, 1] * inMat[1, 2] - inMat[0, 2] * inMat[1, 1]

    out[1, 0] = -(inMat[1, 0] * inMat[2, 2] - inMat[1, 2] * inMat[2, 0])
    out[1, 1] = inMat[0, 0] * inMat[2, 2] - inMat[0, 2] * inMat[2, 0]
    out[1, 2] = -(inMat[0, 0] * inMat[1, 2] - inMat[0, 2] * inMat[1, 0])

    out[2, 0] = inMat[1, 0] * inMat[2, 1] - inMat[1, 1] * inMat[2, 0]
    out[2, 1] = -(inMat[0, 0] * inMat[2, 1] - inMat[0, 1] * inMat[2, 0])
    out[2, 2] = inMat[0, 0] * inMat[1, 1] - inMat[0, 1] * inMat[1, 0]

    return out
}

/// Computes the adjugate of a 3x3 matrix.
/// - Parameter inMat: The input matrix.
/// - Returns: The adjugate of the input matrix.
@inlinable
public func adjugate(_ inMat: Mat3x3d) -> Mat3x3d {
    var out = Mat3x3d.identity

    out[0, 0] = inMat[1, 1] * inMat[2, 2] - inMat[1, 2] * inMat[2, 1]
    out[0, 1] = -(inMat[0, 1] * inMat[2, 2] - inMat[0, 2] * inMat[2, 1])
    out[0, 2] = inMat[0, 1] * inMat[1, 2] - inMat[0, 2] * inMat[1, 1]

    out[1, 0] = -(inMat[1, 0] * inMat[2, 2] - inMat[1, 2] * inMat[2, 0])
    out[1, 1] = inMat[0, 0] * inMat[2, 2] - inMat[0, 2] * inMat[2, 0]
    out[1, 2] = -(inMat[0, 0] * inMat[1, 2] - inMat[0, 2] * inMat[1, 0])

    out[2, 0] = inMat[1, 0] * inMat[2, 1] - inMat[1, 1] * inMat[2, 0]
    out[2, 1] = -(inMat[0, 0] * inMat[2, 1] - inMat[0, 1] * inMat[2, 0])
    out[2, 2] = inMat[0, 0] * inMat[1, 1] - inMat[0, 1] * inMat[1, 0]

    return out
}

/// Computes the adjugate of a 4x4 matrix.
/// - Parameter matrix: The input matrix.
/// - Returns: The adjugate of the input matrix.
@inlinable
public func adjugate(_ matrix: Mat4x4f) -> Mat4x4f {
    adjugateAndDeterminant(matrix).adjugate
}

/// Computes the adjugate of a 4x4 matrix.
/// - Parameter matrix: The input matrix.
/// - Returns: The adjugate of the input matrix.
@inlinable
public func adjugate(_ matrix: Mat4x4d) -> Mat4x4d {
    adjugateAndDeterminant(matrix).adjugate
}
