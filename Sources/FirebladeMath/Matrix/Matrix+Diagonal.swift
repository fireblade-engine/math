//
//  Matrix+SGLMath.swift
//  FirebladeMath
//
//  Created by Christian Treffs on 26.08.19.
//

#if !canImport(simd)
extension Mat3x3d {
    @inlinable public init(diagonal: Double) {
        self.init(diagonal)
    }
}

extension Mat3x3f {
    @inlinable public init(diagonal: Double) {
        self.init(diagonal)
    }
}

extension Mat4x4d {
    @inlinable public init(diagonal: Double) {
        self.init(diagonal)
    }
}

extension Mat4x4f {
    @inlinable public init(diagonal: Double) {
        self.init(diagonal)
    }
}

#endif
