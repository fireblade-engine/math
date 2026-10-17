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
    typealias Vector = Matrix4x4<Storage>.Vector

    // Row-major names: aRC is the element in row R, column C.
    let (col0, col1, col2, col3) = matrix.columns
    let a00 = col0.x, a10 = col0.y, a20 = col0.z, a30 = col0.w
    let a01 = col1.x, a11 = col1.y, a21 = col1.z, a31 = col1.w
    let a02 = col2.x, a12 = col2.y, a22 = col2.z, a32 = col2.w
    let a03 = col3.x, a13 = col3.y, a23 = col3.z, a33 = col3.w

    let s0 = a00 * a11 - a10 * a01
    let s1 = a00 * a12 - a10 * a02
    let s2 = a00 * a13 - a10 * a03
    let s3 = a01 * a12 - a11 * a02
    let s4 = a01 * a13 - a11 * a03
    let s5 = a02 * a13 - a12 * a03

    let c5 = a22 * a33 - a32 * a23
    let c4 = a21 * a33 - a31 * a23
    let c3 = a21 * a32 - a31 * a22
    let c2 = a20 * a33 - a30 * a23
    let c1 = a20 * a32 - a30 * a22
    let c0 = a20 * a31 - a30 * a21

    let determinant = s0 * c5 - s1 * c4 + s2 * c3 + s3 * c2 - s4 * c1 + s5 * c0

    // bRC is the adjugate element in row R, column C; the matrix is built from its columns.
    let b00 = a11 * c5 - a12 * c4 + a13 * c3
    let b10 = -a10 * c5 + a12 * c2 - a13 * c1
    let b20 = a10 * c4 - a11 * c2 + a13 * c0
    let b30 = -a10 * c3 + a11 * c1 - a12 * c0

    let b01 = -a01 * c5 + a02 * c4 - a03 * c3
    let b11 = a00 * c5 - a02 * c2 + a03 * c1
    let b21 = -a00 * c4 + a01 * c2 - a03 * c0
    let b31 = a00 * c3 - a01 * c1 + a02 * c0

    let b02 = a31 * s5 - a32 * s4 + a33 * s3
    let b12 = -a30 * s5 + a32 * s2 - a33 * s1
    let b22 = a30 * s4 - a31 * s2 + a33 * s0
    let b32 = -a30 * s3 + a31 * s1 - a32 * s0

    let b03 = -a21 * s5 + a22 * s4 - a23 * s3
    let b13 = a20 * s5 - a22 * s2 + a23 * s1
    let b23 = -a20 * s4 + a21 * s2 - a23 * s0
    let b33 = a20 * s3 - a21 * s1 + a22 * s0

    let adjugate = Matrix4x4<Storage>(
        Vector(b00, b10, b20, b30),
        Vector(b01, b11, b21, b31),
        Vector(b02, b12, b22, b32),
        Vector(b03, b13, b23, b33)
    )
    return (adjugate, determinant)
}
