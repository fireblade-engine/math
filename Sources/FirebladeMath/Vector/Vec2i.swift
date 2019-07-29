//
//  Vec2i.swift
//  
//
//  Created by Christian Treffs on 23.07.19.
//

import simd.vector

public typealias Vec2i = SIMD2<Int>

extension Vec2i {
    public static let zero = Vec2i(repeating: 0)
    public static let one = Vec2i(repeating: 1)
}
