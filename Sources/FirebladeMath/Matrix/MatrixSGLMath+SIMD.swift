//
//  Matrix+SGLMath.swift
//  FirebladeMath
//
//  Created by Christian Treffs on 27.08.19.
//

import struct SGLMath.Vector3
import struct SGLMath.Vector4

import struct SGLMath.Matrix3x3
import struct SGLMath.Matrix4x4

extension Matrix3x3 where Element: Scalar {
    public init(_ columns: [SIMD3<Element>]) {
        self.init(columns[0],
                  columns[1],
                  columns[2])
    }

    public init(_ column1: SIMD3<Element>,
                _ column2: SIMD3<Element>,
                _ column3: SIMD3<Element>) {
        self.init(Vector3<Element>(column1),
                  Vector3<Element>(column2),
                  Vector3<Element>(column3))
    }
}

extension Matrix4x4 where Element: Scalar {
    public init(_ columns: [SIMD4<Element>]) {
        self.init(columns[0],
                  columns[1],
                  columns[2],
                  columns[3])
    }

    public init(_ column1: SIMD4<Element>,
                _ column2: SIMD4<Element>,
                _ column3: SIMD4<Element>,
                _ column4: SIMD4<Element>) {
        self.init(Vector4<Element>(column1),
                  Vector4<Element>(column2),
                  Vector4<Element>(column3),
                  Vector4<Element>(column4))
    }
}
