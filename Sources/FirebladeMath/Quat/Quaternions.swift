#if FRB_MATH_USE_SIMD
import struct simd.simd_quatd
import struct simd.simd_quatf

/// A quaternion of double-precision floating-point numbers.
public typealias Quat4d = Quaternion<simd_quatd>
/// A quaternion of single-precision floating-point numbers.
public typealias Quat4f = Quaternion<simd_quatf>
#else
/// A quaternion of double-precision floating-point numbers.
public typealias Quat4d = Quaternion<QuaternionStorage<Double>>
/// A quaternion of single-precision floating-point numbers.
public typealias Quat4f = Quaternion<QuaternionStorage<Float>>
#endif