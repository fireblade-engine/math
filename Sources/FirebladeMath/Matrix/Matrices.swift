#if FRB_MATH_USE_SIMD
import struct simd.simd_double2x2
import struct simd.simd_double3x3
import struct simd.simd_double4x4
import struct simd.simd_float2x2
import struct simd.simd_float3x3
import struct simd.simd_float4x4
import func simd.simd_mul

/// A 4x4 matrix of single-precision floating-point numbers.
public typealias Mat4x4f = Matrix4x4<simd_float4x4>
/// A 4x4 matrix of double-precision floating-point numbers.
public typealias Mat4x4d = Matrix4x4<simd_double4x4>
/// A 3x3 matrix of single-precision floating-point numbers.
public typealias Mat3x3f = Matrix3x3<simd_float3x3>
/// A 3x3 matrix of double-precision floating-point numbers.
public typealias Mat3x3d = Matrix3x3<simd_double3x3>
/// A 2x2 matrix of single-precision floating-point numbers.
public typealias Mat2x2f = Matrix2x2<simd_float2x2>
/// A 2x2 matrix of double-precision floating-point numbers.
public typealias Mat2x2d = Matrix2x2<simd_double2x2>

#else

/// A 4x4 matrix of single-precision floating-point numbers.
public typealias Mat4x4f = Matrix4x4<Storage4x4<Float>>
/// A 4x4 matrix of double-precision floating-point numbers.
public typealias Mat4x4d = Matrix4x4<Storage4x4<Double>>
/// A 3x3 matrix of single-precision floating-point numbers.
public typealias Mat3x3f = Matrix3x3<Storage3x3<Float>>
/// A 3x3 matrix of double-precision floating-point numbers.
public typealias Mat3x3d = Matrix3x3<Storage3x3<Double>>
/// A 2x2 matrix of single-precision floating-point numbers.
public typealias Mat2x2f = Matrix2x2<Storage2x2<Float>>
/// A 2x2 matrix of double-precision floating-point numbers.
public typealias Mat2x2d = Matrix2x2<Storage2x2<Double>>

#endif

/// Get index for matrix column and row.
/// - Parameters:
///   - column: The column (zero based).
///   - row: The row (zero based).
///   - width: The width of a column.
/// - Returns: The flat index into the matrix storage.
@inlinable
public func index(column: Int, row: Int, width: Int) -> Int {
    (row * width) + column
}

/// Get column and row for matrix by index.
/// - Parameters:
///   - index: The index into the matrix.
///   - width: The width of a column.
/// - Returns: A tuple containing the column and row indices.
@inlinable
public func columnRow(index: Int, width: Int) -> (column: Int, row: Int) {
    let row: Int = index % width
    let column: Int = index / width
    return (column, row)
}
