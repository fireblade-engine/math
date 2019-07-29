//
//  Vec2u.swift
//  
//
//  Created by Christian Treffs on 23.07.19.
//

import simd.vector

public typealias Vec2u = SIMD2<UInt>

extension Vec2u {
    public static let zero = Vec2u(repeating: 0)
    public static let one = Vec2u(repeating: 1)
}
