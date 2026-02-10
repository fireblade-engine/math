#if FRB_MATH_USE_SIMD
import struct simd.simd_quatd
import struct simd.simd_quatf

public typealias Quat4d = Quaternion<simd_quatd>
public typealias Quat4f = Quaternion<simd_quatf>
#else
public typealias Quat4d = Quaternion<QuaternionStorage<Double>>
public typealias Quat4f = Quaternion<QuaternionStorage<Float>>
#endif
