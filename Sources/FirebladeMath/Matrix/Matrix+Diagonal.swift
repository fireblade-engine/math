//
//  Matrix+SGLMath.swift
//  FirebladeMath
//
//  Created by Christian Treffs on 26.08.19.
//

#if !canImport(simd)
extension Mat3x3d {
    @inlinable public init(diagonal: Vec3d) {
        self.init([diagonal.x, 0, 0],
                  [0, diagonal.y, 0],
                  [0, 0, diagonal.z])
    }
}

extension Mat3x3f {
    @inlinable public init(diagonal: Vec3f) {
        self.init([diagonal.x, 0, 0],
                  [0, diagonal.y, 0],
                  [0, 0, diagonal.z])
    }
}

extension Mat4x4d {
    @inlinable public init(diagonal: Vec4d) {
        self.init([diagonal.x, 0, 0, 0],
                  [0, diagonal.y, 0, 0],
                  [0, 0, diagonal.z, 0],
                  [0, 0, 0, diagonal.w])
    }
}

extension Mat4x4f {
    @inlinable public init(diagonal: Vec4f) {
        self.init([diagonal.x, 0, 0, 0],
                  [0, diagonal.y, 0, 0],
                  [0, 0, diagonal.z, 0],
                  [0, 0, 0, diagonal.w])
    }
}
#endif
