//
//  Vec3u.swift
//  
//
//  Created by Christian Treffs on 23.07.19.
//

import simd.vector

public typealias Vec3u = SIMD3<UInt>

extension Vec3u {
    public static let zero = Vec3u(repeating: 0)
    public static let one = Vec3u(repeating: 1)
}
