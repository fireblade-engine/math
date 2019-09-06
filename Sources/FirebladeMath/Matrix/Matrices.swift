//
//  Matrices.swift
//  FirebladeMath
//
//  Created by Christian Treffs on 26.08.19.
//

#if canImport(simd)
import struct simd.matrix.simd_float4x4
import struct simd.matrix.simd_double4x4
import struct simd.matrix.simd_float3x3
import struct simd.matrix.simd_double3x3
#endif

#if USE_SIMD

public typealias Mat4x4f = Matrix4x4<simd_float4x4>
public typealias Mat4x4d = Matrix4x4<simd_double4x4>

public typealias Mat3x3f = Matrix3x3<simd_float3x3>
public typealias Mat3x3d = Matrix3x3<simd_double3x3>

#else

public typealias Mat4x4f = Matrix4x4<Storage4x4<Float>>
public typealias Mat4x4d = Matrix4x4<Storage4x4<Double>>

public typealias Mat3x3f = Matrix3x3<Storage3x3<Float>>
public typealias Mat3x3d = Matrix3x3<Storage3x3<Double>>

#endif
