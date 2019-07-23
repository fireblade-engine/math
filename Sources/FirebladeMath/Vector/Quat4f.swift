//
//  Quat4f.swift
//  
//
//  Created by Christian Treffs on 23.07.19.
//

import simd

public typealias Quat4f = simd_quatf

extension Quat4f: IdentitiyProviding {
    public static let identity = Quat4f(ix: 0, iy: 0, iz: 0, r: 1)
}
