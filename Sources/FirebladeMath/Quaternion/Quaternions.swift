//
//  Quaternions.swift
//  FirebladeMath
//
//  Created by Christian Treffs on 26.08.19.
//

#if canImport(simd)
import struct simd.quaternion.simd_quatd
import struct simd.quaternion.simd_quatf
#endif

#if USE_SIMD
public typealias Quat4d = Quaternion<simd_quatd>
public typealias Quat4f = Quaternion<simd_quatf>
#else
public typealias Quat4d = Quaternion<QuaternionStorage<Double>>
public typealias Quat4f = Quaternion<QuaternionStorage<Float>>
#endif
