//
//  MatrixSGLMath+Quaternion.swift
//  FirebladeMath
//
//  Created by Christian Treffs on 27.08.19.
//

import struct SGLMath.Matrix4x4
import struct SGLMath.Matrix3x3
import struct SGLMath.Quaternion

extension Matrix4x4 where Element: FloatingPointScalar {
    public init(_ quaternion: Quaternion<Element>) {
        fatalError("implementation missing")
    }
}

extension Matrix3x3 where Element: FloatingPointScalar {
    public init(_ quaternion: Quaternion<Element>) {
        fatalError("implementation missing")
    }
}
