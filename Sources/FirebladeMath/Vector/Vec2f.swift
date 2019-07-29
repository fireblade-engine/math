//
//  Vec2f.swift
//  
//
//  Created by Christian Treffs on 23.07.19.
//

import simd.vector

public typealias Vec2f = SIMD2<Float>

extension Vec2f {
    public static let zero = Vec2f(repeating: 0)
    public static let one = Vec2f(repeating: 1)
}
