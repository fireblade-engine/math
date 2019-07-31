//
//  Vec4f.swift
//  
//
//  Created by Christian Treffs on 23.07.19.
//

import func simd.simd_length
import func simd.simd_normalize

public typealias Vec4f = SIMD4<Float>

extension Vec4f {
    @inlinable public var xyz: Vec3f {
        return Vec3f(x, y, z)
    }

    @inlinable public var length: Float {
        return simd_length(self)
    }

    @inlinable public var normalized: Self {
        return simd_normalize(self)
    }

    @inlinable public var isNaN: Bool {
        return x.isNaN || y.isNaN || z.isNaN || w.isNaN
    }
}

extension Vec4f {
    public static let zero = Vec4f(repeating: 0)
    public static let one = Vec4f(repeating: 1)
}
