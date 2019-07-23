//
//  Quad4d.swift
//  
//
//  Created by Christian Treffs on 23.07.19.
//

public typealias Quat4d = simd_quatd

extension Quat4d: IdentitiyProviding {
    public static let identity = Quat4d(ix: 0, iy: 0, iz: 0, r: 1)
}
