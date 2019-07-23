//
//  Vec4f.swift
//  
//
//  Created by Christian Treffs on 23.07.19.
//

import simd

public typealias Vec4f = SIMD4<Float>

extension Vec4f {
    @inlinable public var xyz: Vec3f {
        return Vec3f(x, y, z)
    }

    @inlinable var length: Float {
        return simd_length(self)
    }

    @inlinable var normalized: Self {
        return simd_normalize(self)
    }
}

extension Vec4f {
    public static let zero = Vec4f(repeating: 0)
    public static let one = Vec4f(repeating: 1)
}
