//
//  Matrices.swift
//  FirebladeMath
//
//  Created by Christian Treffs on 26.08.19.
//

#if canImport(simd)
import struct simd.matrix.simd_double3x3
import struct simd.matrix.simd_float3x3
import struct simd.matrix.simd_double4x4
import struct simd.matrix.simd_float4x4

public typealias Mat3x3d = simd_double3x3
public typealias Mat3x3f = simd_float3x3

public typealias Mat4x4d = simd_double4x4
public typealias Mat4x4f = simd_float4x4

#else

import struct SGLMath.Matrix3x3
import struct SGLMath.Matrix4x4

public typealias Mat3x3d = SGLMath.Matrix3x3<Double>
public typealias Mat3x3f = SGLMath.Matrix3x3<Float>

public typealias Mat4x4d = SGLMath.Matrix4x4<Double>
public typealias Mat4x4f = SGLMath.Matrix4x4<Float>

#endif
