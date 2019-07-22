//
//  Vec4f+Extensions.swift
//  
//
//  Created by Christian Treffs on 30.06.19.
//

import simd

public extension Vec4f {
    @inlinable var xyz: Vec3f {
        return Vec3f(x, y, z)
    }

    @inlinable var lengthPrecise: Float {
        return simd_precise_length(self)
    }

    @inlinable var lengthFast: Float {
        return simd_fast_length(self)
    }

    @inlinable var length: Float {
        return simd_length(self)
    }

    @inlinable var lengthSquared: Float {
        return simd_length_squared(self)
    }

    @inlinable var normalizedPrecise: Self {
        return simd_precise_normalize(self)
    }

    @inlinable var normalizedFast: Self {
        return simd_fast_normalize(self)
    }

    @inlinable var normalized: Self {
        return simd_normalize(self)
    }
}
/*

 simd_norm_one(<#CODE#>)
 simd_norm_inf(<#CODE#>)

 */
