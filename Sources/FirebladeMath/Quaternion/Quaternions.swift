//
//  Quaternions.swift
//  FirebladeMath
//
//  Created by Christian Treffs on 26.08.19.
//

#if canImport(simd)
import struct simd.quaternion.simd_quatd
import struct simd.quaternion.simd_quatf

public typealias Quat4d = simd_quatd
public typealias Quat4f = simd_quatf

#else
import struct SGLMath.Quaternion

public typealias Quat4d = Quaternion<Double>
public typealias Quat4f = Quaternion<Float>
#endif
