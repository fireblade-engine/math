//
//  Vec2d.swift
//  
//
//  Created by Christian Treffs on 23.07.19.
//

import simd.vector

public typealias Vec2d = SIMD2<Double>

extension Vec2d {
    public static let zero = Vec2d(repeating: 0)
    public static let one = Vec2d(repeating: 1)
}
