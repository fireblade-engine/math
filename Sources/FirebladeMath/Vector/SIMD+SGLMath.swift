//
//  SIMD+SGLMath.swift
//  FirebladeMath
//
//  Created by Christian Treffs on 26.08.19.
//

import protocol SGLMath.ArithmeticType
import struct SGLMath.Vector2
import struct SGLMath.Vector3
import struct SGLMath.Vector4

extension Vector2 where T: SIMDScalar & ArithmeticType {
    @inlinable public init(_ simd: SIMD2<T>) {
        self.init(simd.x, simd.y)
    }

    @inlinable public var simd: SIMD2<T> {
        return SIMD2<T>(x: x, y: y)
    }
}

extension Vector3 where T: SIMDScalar & ArithmeticType {
    @inlinable public init(_ simd: SIMD3<T>) {
        self.init(simd.x, simd.y, simd.z)
    }

    @inlinable public var simd: SIMD3<T> {
        return SIMD3<T>(x: x, y: y, z: z)
    }
}

extension Vector4 where T: SIMDScalar & ArithmeticType {
    @inlinable public init(_ simd: SIMD4<T>) {
        self.init(simd.x, simd.y, simd.z, simd.w)
    }

    @inlinable public var simd: SIMD4<T> {
        return SIMD4<T>(x: x, y: y, z: z, w: w)
    }
}
