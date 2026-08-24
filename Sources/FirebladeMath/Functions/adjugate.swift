/// Computes the adjugate of a 3x3 matrix.
/// - Parameter inMat: The input matrix.
/// - Returns: The adjugate of the input matrix.
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
public func adjugate(_ matrix: Mat4x4f) -> Mat4x4f {
    // Adjugate is the transpose of the cofactor matrix.
    // cofactor(i, j) = (-1)^(i+j) * minor(i, j)
    // Here we use matrix[col, row] indexing.
    var res = Mat4x4f.identity

    res[0, 0] = matrix[1, 1] * (matrix[2, 2] * matrix[3, 3] - matrix[2, 3] * matrix[3, 2]) - matrix[2, 1] * (matrix[1, 2] * matrix[3, 3] - matrix[1, 3] * matrix[3, 2]) + matrix[3, 1] * (matrix[1, 2] * matrix[2, 3] - matrix[1, 3] * matrix[2, 2])
    res[1, 0] = -(matrix[1, 0] * (matrix[2, 2] * matrix[3, 3] - matrix[2, 3] * matrix[3, 2]) - matrix[2, 0] * (matrix[1, 2] * matrix[3, 3] - matrix[1, 3] * matrix[3, 2]) + matrix[3, 0] * (matrix[1, 2] * matrix[2, 3] - matrix[1, 3] * matrix[2, 2]))
    res[2, 0] = matrix[1, 0] * (matrix[2, 1] * matrix[3, 3] - matrix[2, 3] * matrix[3, 1]) - matrix[2, 0] * (matrix[1, 1] * matrix[3, 3] - matrix[1, 3] * matrix[3, 1]) + matrix[3, 0] * (matrix[1, 1] * matrix[2, 3] - matrix[1, 3] * matrix[2, 1])
    res[3, 0] = -(matrix[1, 0] * (matrix[2, 1] * matrix[3, 2] - matrix[2, 2] * matrix[3, 1]) - matrix[2, 0] * (matrix[1, 1] * matrix[3, 2] - matrix[1, 2] * matrix[3, 1]) + matrix[3, 0] * (matrix[1, 1] * matrix[2, 2] - matrix[1, 2] * matrix[2, 1]))

    res[0, 1] = -(matrix[0, 1] * (matrix[2, 2] * matrix[3, 3] - matrix[2, 3] * matrix[3, 2]) - matrix[2, 1] * (matrix[0, 2] * matrix[3, 3] - matrix[0, 3] * matrix[3, 2]) + matrix[3, 1] * (matrix[0, 2] * matrix[2, 3] - matrix[0, 3] * matrix[2, 2]))
    res[1, 1] = matrix[0, 0] * (matrix[2, 2] * matrix[3, 3] - matrix[2, 3] * matrix[3, 2]) - matrix[2, 0] * (matrix[0, 2] * matrix[3, 3] - matrix[0, 3] * matrix[3, 2]) + matrix[3, 0] * (matrix[0, 2] * matrix[2, 3] - matrix[0, 3] * matrix[2, 2])
    res[2, 1] = -(matrix[0, 0] * (matrix[2, 1] * matrix[3, 3] - matrix[2, 3] * matrix[3, 1]) - matrix[2, 0] * (matrix[0, 1] * matrix[3, 3] - matrix[0, 3] * matrix[3, 1]) + matrix[3, 0] * (matrix[0, 1] * matrix[2, 3] - matrix[0, 3] * matrix[2, 1]))
    res[3, 1] = matrix[0, 0] * (matrix[2, 1] * matrix[3, 2] - matrix[2, 2] * matrix[3, 1]) - matrix[2, 0] * (matrix[0, 1] * matrix[3, 2] - matrix[0, 2] * matrix[3, 1]) + matrix[3, 0] * (matrix[0, 1] * matrix[2, 2] - matrix[0, 2] * matrix[2, 1])

    res[0, 2] = matrix[0, 1] * (matrix[1, 2] * matrix[3, 3] - matrix[1, 3] * matrix[3, 2]) - matrix[1, 1] * (matrix[0, 2] * matrix[3, 3] - matrix[0, 3] * matrix[3, 2]) + matrix[3, 1] * (matrix[0, 2] * matrix[1, 3] - matrix[0, 3] * matrix[1, 2])
    res[1, 2] = -(matrix[0, 0] * (matrix[1, 2] * matrix[3, 3] - matrix[1, 3] * matrix[3, 2]) - matrix[1, 0] * (matrix[0, 2] * matrix[3, 3] - matrix[0, 3] * matrix[3, 2]) + matrix[3, 0] * (matrix[0, 2] * matrix[1, 3] - matrix[0, 3] * matrix[1, 2]))
    res[2, 2] = matrix[0, 0] * (matrix[1, 1] * matrix[3, 3] - matrix[1, 3] * matrix[3, 1]) - matrix[1, 0] * (matrix[0, 1] * matrix[3, 3] - matrix[0, 3] * matrix[3, 1]) + matrix[3, 0] * (matrix[0, 1] * matrix[1, 3] - matrix[0, 3] * matrix[1, 1])
    res[3, 2] = -(matrix[0, 0] * (matrix[1, 1] * matrix[3, 2] - matrix[1, 2] * matrix[3, 1]) - matrix[1, 0] * (matrix[0, 1] * matrix[3, 2] - matrix[0, 2] * matrix[3, 1]) + matrix[3, 0] * (matrix[0, 1] * matrix[1, 2] - matrix[0, 2] * matrix[1, 1]))

    res[0, 3] = -(matrix[0, 1] * (matrix[1, 2] * matrix[2, 3] - matrix[1, 3] * matrix[2, 2]) - matrix[1, 1] * (matrix[0, 2] * matrix[2, 3] - matrix[0, 3] * matrix[2, 2]) + matrix[2, 1] * (matrix[0, 2] * matrix[1, 3] - matrix[0, 3] * matrix[1, 2]))
    res[1, 3] = matrix[0, 0] * (matrix[1, 2] * matrix[2, 3] - matrix[1, 3] * matrix[2, 2]) - matrix[1, 0] * (matrix[0, 2] * matrix[2, 3] - matrix[0, 3] * matrix[2, 2]) + matrix[2, 0] * (matrix[0, 2] * matrix[1, 3] - matrix[0, 3] * matrix[1, 2])
    res[2, 3] = -(matrix[0, 0] * (matrix[1, 1] * matrix[2, 3] - matrix[1, 3] * matrix[2, 1]) - matrix[1, 0] * (matrix[0, 1] * matrix[2, 3] - matrix[0, 3] * matrix[2, 1]) + matrix[2, 0] * (matrix[0, 1] * matrix[1, 3] - matrix[0, 3] * matrix[1, 1]))
    res[3, 3] = matrix[0, 0] * (matrix[1, 1] * matrix[2, 2] - matrix[1, 2] * matrix[2, 1]) - matrix[1, 0] * (matrix[0, 1] * matrix[2, 2] - matrix[0, 2] * matrix[2, 1]) + matrix[2, 0] * (matrix[0, 1] * matrix[1, 2] - matrix[0, 2] * matrix[1, 1])

    return res
}

/// Computes the adjugate of a 4x4 matrix.
/// - Parameter matrix: The input matrix.
/// - Returns: The adjugate of the input matrix.
public func adjugate(_ matrix: Mat4x4d) -> Mat4x4d {
    var res = Mat4x4d.identity

    res[0, 0] = matrix[1, 1] * (matrix[2, 2] * matrix[3, 3] - matrix[2, 3] * matrix[3, 2]) - matrix[2, 1] * (matrix[1, 2] * matrix[3, 3] - matrix[1, 3] * matrix[3, 2]) + matrix[3, 1] * (matrix[1, 2] * matrix[2, 3] - matrix[1, 3] * matrix[2, 2])
    res[1, 0] = -(matrix[1, 0] * (matrix[2, 2] * matrix[3, 3] - matrix[2, 3] * matrix[3, 2]) - matrix[2, 0] * (matrix[1, 2] * matrix[3, 3] - matrix[1, 3] * matrix[3, 2]) + matrix[3, 0] * (matrix[1, 2] * matrix[2, 3] - matrix[1, 3] * matrix[2, 2]))
    res[2, 0] = matrix[1, 0] * (matrix[2, 1] * matrix[3, 3] - matrix[2, 3] * matrix[3, 1]) - matrix[2, 0] * (matrix[1, 1] * matrix[3, 3] - matrix[1, 3] * matrix[3, 1]) + matrix[3, 0] * (matrix[1, 1] * matrix[2, 3] - matrix[1, 3] * matrix[2, 1])
    res[3, 0] = -(matrix[1, 0] * (matrix[2, 1] * matrix[3, 2] - matrix[2, 2] * matrix[3, 1]) - matrix[2, 0] * (matrix[1, 1] * matrix[3, 2] - matrix[1, 2] * matrix[3, 1]) + matrix[3, 0] * (matrix[1, 1] * matrix[2, 2] - matrix[1, 2] * matrix[2, 1]))

    res[0, 1] = -(matrix[0, 1] * (matrix[2, 2] * matrix[3, 3] - matrix[2, 3] * matrix[3, 2]) - matrix[2, 1] * (matrix[0, 2] * matrix[3, 3] - matrix[0, 3] * matrix[3, 2]) + matrix[3, 1] * (matrix[0, 2] * matrix[2, 3] - matrix[0, 3] * matrix[2, 2]))
    res[1, 1] = matrix[0, 0] * (matrix[2, 2] * matrix[3, 3] - matrix[2, 3] * matrix[3, 2]) - matrix[2, 0] * (matrix[0, 2] * matrix[3, 3] - matrix[0, 3] * matrix[3, 2]) + matrix[3, 0] * (matrix[0, 2] * matrix[2, 3] - matrix[0, 3] * matrix[2, 2])
    res[2, 1] = -(matrix[0, 0] * (matrix[2, 1] * matrix[3, 3] - matrix[2, 3] * matrix[3, 1]) - matrix[2, 0] * (matrix[0, 1] * matrix[3, 3] - matrix[0, 3] * matrix[3, 1]) + matrix[3, 0] * (matrix[0, 1] * matrix[2, 3] - matrix[0, 3] * matrix[2, 1]))
    res[3, 1] = matrix[0, 0] * (matrix[2, 1] * matrix[3, 2] - matrix[2, 2] * matrix[3, 1]) - matrix[2, 0] * (matrix[0, 1] * matrix[3, 2] - matrix[0, 2] * matrix[3, 1]) + matrix[3, 0] * (matrix[0, 1] * matrix[2, 2] - matrix[0, 2] * matrix[2, 1])

    res[0, 2] = matrix[0, 1] * (matrix[1, 2] * matrix[3, 3] - matrix[1, 3] * matrix[3, 2]) - matrix[1, 1] * (matrix[0, 2] * matrix[3, 3] - matrix[0, 3] * matrix[3, 2]) + matrix[3, 1] * (matrix[0, 2] * matrix[1, 3] - matrix[0, 3] * matrix[1, 2])
    res[1, 2] = -(matrix[0, 0] * (matrix[1, 2] * matrix[3, 3] - matrix[1, 3] * matrix[3, 2]) - matrix[1, 0] * (matrix[0, 2] * matrix[3, 3] - matrix[0, 3] * matrix[3, 2]) + matrix[3, 0] * (matrix[0, 2] * matrix[1, 3] - matrix[0, 3] * matrix[1, 2]))
    res[2, 2] = matrix[0, 0] * (matrix[1, 1] * matrix[3, 3] - matrix[1, 3] * matrix[3, 1]) - matrix[1, 0] * (matrix[0, 1] * matrix[3, 3] - matrix[0, 3] * matrix[3, 1]) + matrix[3, 0] * (matrix[0, 1] * matrix[1, 3] - matrix[0, 3] * matrix[1, 1])
    res[3, 2] = -(matrix[0, 0] * (matrix[1, 1] * matrix[3, 2] - matrix[1, 2] * matrix[3, 1]) - matrix[1, 0] * (matrix[0, 1] * matrix[3, 2] - matrix[0, 2] * matrix[3, 1]) + matrix[3, 0] * (matrix[0, 1] * matrix[1, 2] - matrix[0, 2] * matrix[1, 1]))

    res[0, 3] = -(matrix[0, 1] * (matrix[1, 2] * matrix[2, 3] - matrix[1, 3] * matrix[2, 2]) - matrix[1, 1] * (matrix[0, 2] * matrix[2, 3] - matrix[0, 3] * matrix[2, 2]) + matrix[2, 1] * (matrix[0, 2] * matrix[1, 3] - matrix[0, 3] * matrix[1, 2]))
    res[1, 3] = matrix[0, 0] * (matrix[1, 2] * matrix[2, 3] - matrix[1, 3] * matrix[2, 2]) - matrix[1, 0] * (matrix[0, 2] * matrix[2, 3] - matrix[0, 3] * matrix[2, 2]) + matrix[2, 0] * (matrix[0, 2] * matrix[1, 3] - matrix[0, 3] * matrix[1, 2])
    res[2, 3] = -(matrix[0, 0] * (matrix[1, 1] * matrix[2, 3] - matrix[1, 3] * matrix[2, 1]) - matrix[1, 0] * (matrix[0, 1] * matrix[2, 3] - matrix[0, 3] * matrix[2, 1]) + matrix[2, 0] * (matrix[0, 1] * matrix[1, 3] - matrix[0, 3] * matrix[1, 1]))
    res[3, 3] = matrix[0, 0] * (matrix[1, 1] * matrix[2, 2] - matrix[1, 2] * matrix[2, 1]) - matrix[1, 0] * (matrix[0, 1] * matrix[2, 2] - matrix[0, 2] * matrix[2, 1]) + matrix[2, 0] * (matrix[0, 1] * matrix[1, 2] - matrix[0, 2] * matrix[1, 1])

    return res
}
