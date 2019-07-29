//
//  Vec3f.swift
//  
//
//  Created by Christian Treffs on 23.07.19.
//

import func simd.simd_length
import func simd.simd_normalize

public typealias Vec3f = SIMD3<Float>

extension Vec3f {
    public static let zero = Vec3f(repeating: 0)
    public static let one = Vec3f(repeating: 1)
}

extension Vec3f {
    @inlinable public var length: Float {
        return simd_length(self)
    }

    @inlinable public var normalized: Self {
        return simd_normalize(self)
    }
}

extension Vec3f {
    public static let axisX: Vec3f = [1, 0, 0]
    public static let axisY: Vec3f = [0, 1, 0]
    public static let axisZ: Vec3f = [0, 0, 1]
}
