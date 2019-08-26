//
//  Quad4d.swift
//
//
//  Created by Christian Treffs on 23.07.19.
//

#if canImport(simd)
import struct simd.quaternion.simd_quatd
public typealias Quat4d = simd_quatd
#else
import struct SGLMath.Quaternion
public typealias Quat4d = Quaternion<Float64>
#endif

extension Quat4d {
    public static let identity = Quat4d(ix: 0, iy: 0, iz: 0, r: 1)
}
