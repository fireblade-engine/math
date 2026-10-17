/// Computes the adjugate and the determinant of a 4x4 matrix in one pass.
///
/// Uses the Laplace expansion by 2x2 minors: the six 2x2 sub-determinants of the first two rows
/// (`s0...s5`) and of the last two rows (`c0...c5`) are computed once and shared by all sixteen
/// cofactors and the determinant, instead of re-deriving each 3x3 minor from scratch.
///
/// - Parameter matrix: The matrix.
/// - Returns: The adjugate (transposed cofactor matrix) and the determinant of `matrix`.
@inlinable
func adjugateAndDeterminant<Storage>(_ matrix: Matrix4x4<Storage>) -> (adjugate: Matrix4x4<Storage>, determinant: Storage.Value) { // swiftlint:disable:this explicit_top_level_acl
    typealias Value = Storage.Value
    typealias Vector = Matrix4x4<Storage>.Vector

    // Every intermediate is explicitly typed and kept short: older compilers (Swift 6.1/6.2)
    // otherwise fail to type-check these generic expressions in reasonable time.

    // Row-major names: aRC is the element in row R, column C.
    let (col0, col1, col2, col3) = matrix.columns
    let a00: Value = col0.x, a10: Value = col0.y, a20: Value = col0.z, a30: Value = col0.w
    let a01: Value = col1.x, a11: Value = col1.y, a21: Value = col1.z, a31: Value = col1.w
    let a02: Value = col2.x, a12: Value = col2.y, a22: Value = col2.z, a32: Value = col2.w
    let a03: Value = col3.x, a13: Value = col3.y, a23: Value = col3.z, a33: Value = col3.w

    let s0: Value = a00 * a11 - a10 * a01
    let s1: Value = a00 * a12 - a10 * a02
    let s2: Value = a00 * a13 - a10 * a03
    let s3: Value = a01 * a12 - a11 * a02
    let s4: Value = a01 * a13 - a11 * a03
    let s5: Value = a02 * a13 - a12 * a03

    let c5: Value = a22 * a33 - a32 * a23
    let c4: Value = a21 * a33 - a31 * a23
    let c3: Value = a21 * a32 - a31 * a22
    let c2: Value = a20 * a33 - a30 * a23
    let c1: Value = a20 * a32 - a30 * a22
    let c0: Value = a20 * a31 - a30 * a21

    let determinant01: Value = s0 * c5 - s1 * c4
    let determinant23: Value = s2 * c3 + s3 * c2
    let determinant45: Value = s5 * c0 - s4 * c1
    let determinant: Value = determinant01 + determinant23 + determinant45

    // bRC is the adjugate element in row R, column C; the matrix is built from its columns.
    let b00: Value = a11 * c5 - a12 * c4 + a13 * c3
    let b10: Value = -a10 * c5 + a12 * c2 - a13 * c1
    let b20: Value = a10 * c4 - a11 * c2 + a13 * c0
    let b30: Value = -a10 * c3 + a11 * c1 - a12 * c0

    let b01: Value = -a01 * c5 + a02 * c4 - a03 * c3
    let b11: Value = a00 * c5 - a02 * c2 + a03 * c1
    let b21: Value = -a00 * c4 + a01 * c2 - a03 * c0
    let b31: Value = a00 * c3 - a01 * c1 + a02 * c0

    let b02: Value = a31 * s5 - a32 * s4 + a33 * s3
    let b12: Value = -a30 * s5 + a32 * s2 - a33 * s1
    let b22: Value = a30 * s4 - a31 * s2 + a33 * s0
    let b32: Value = -a30 * s3 + a31 * s1 - a32 * s0

    let b03: Value = -a21 * s5 + a22 * s4 - a23 * s3
    let b13: Value = a20 * s5 - a22 * s2 + a23 * s1
    let b23: Value = -a20 * s4 + a21 * s2 - a23 * s0
    let b33: Value = a20 * s3 - a21 * s1 + a22 * s0

    let adjugate = Matrix4x4<Storage>(
        Vector(b00, b10, b20, b30),
        Vector(b01, b11, b21, b31),
        Vector(b02, b12, b22, b32),
        Vector(b03, b13, b23, b33)
    )
    return (adjugate, determinant)
}
