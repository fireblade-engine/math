#if FRB_MATH_USE_SIMD
import struct simd.simd_double2x2
import struct simd.simd_double3x3
import struct simd.simd_double4x4
import struct simd.simd_float2x2
import struct simd.simd_float3x3
import struct simd.simd_float4x4
#endif

extension Mat2x2f {
    /// The 2x2 identity matrix.
    @inlinable public static var identity: Mat2x2f {
        Mat2x2f(diagonal: Vector(1.0, 1.0))
    }
}

extension Mat2x2d {
    /// The 2x2 identity matrix.
    @inlinable public static var identity: Mat2x2d {
        Mat2x2d(diagonal: Vector(1.0, 1.0))
    }
}

extension Mat3x3f {
    /// The 3x3 identity matrix.
    @inlinable public static var identity: Mat3x3f {
        Mat3x3f(diagonal: Vector(1.0, 1.0, 1.0))
    }
}

extension Mat3x3d {
    /// The 3x3 identity matrix.
    @inlinable public static var identity: Mat3x3d {
        Mat3x3d(diagonal: Vector(1.0, 1.0, 1.0))
    }
}

extension Mat4x4f {
    /// The 4x4 identity matrix.
    @inlinable public static var identity: Mat4x4f {
        Mat4x4f(diagonal: Vector(1.0, 1.0, 1.0, 1.0))
    }
}

extension Mat4x4d {
    /// The 4x4 identity matrix.
    @inlinable public static var identity: Mat4x4d {
        Mat4x4d(diagonal: Vector(1.0, 1.0, 1.0, 1.0))
    }
}
