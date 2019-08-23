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
#error("can not import simd")
#endif

extension Quat4d: IdentitiyProviding {
    public static let identity = Quat4d(ix: 0, iy: 0, iz: 0, r: 1)
}
