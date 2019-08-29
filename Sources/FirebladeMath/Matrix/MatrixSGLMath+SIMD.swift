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
    @inlinable public init(_ columns: [SIMD3<Element>]) {
        self.init(columns[0],
                  columns[1],
                  columns[2])
    }

    @inlinable public init(_ column1: SIMD3<Element>,
                           _ column2: SIMD3<Element>,
                           _ column3: SIMD3<Element>) {
        self.init(Vector3<Element>(column1),
                  Vector3<Element>(column2),
                  Vector3<Element>(column3))
    }

    @inlinable public init(diagonal: Vector3<Element>) {
        self.init(Vector3<Element>(diagonal.x, 0, 0),
                  Vector3<Element>(0, diagonal.y, 0),
                  Vector3<Element>(0, 0, diagonal.z))
    }

    @inlinable public var columns: (SIMD3<Element>, SIMD3<Element>, SIMD3<Element>) {
        return (SIMD3<Element>(elements[0...2]),
                SIMD3<Element>(elements[3...5]),
                SIMD3<Element>(elements[6...8]))
    }
}

extension Matrix4x4 where Element: Scalar {
    @inlinable public init(_ columns: [SIMD4<Element>]) {
        self.init(columns[0],
                  columns[1],
                  columns[2],
                  columns[3])
    }

    @inlinable public init(_ column1: SIMD4<Element>,
                           _ column2: SIMD4<Element>,
                           _ column3: SIMD4<Element>,
                           _ column4: SIMD4<Element>) {
        self.init(Vector4<Element>(column1),
                  Vector4<Element>(column2),
                  Vector4<Element>(column3),
                  Vector4<Element>(column4))
    }

    @inlinable public init(diagonal: Vector4<Element>) {
        self.init(Vector4<Element>(diagonal.x, 0, 0, 0),
                  Vector4<Element>(0, diagonal.y, 0, 0),
                  Vector4<Element>(0, 0, diagonal.z, 0),
                  Vector4<Element>(0, 0, 0, diagonal.w))
    }

    // swiftlint:disable large_tuple
    @inlinable public var columns: (SIMD4<Element>, SIMD4<Element>, SIMD4<Element>, SIMD4<Element>) {
        return (SIMD4<Element>(elements[0...3]),
                SIMD4<Element>(elements[4...7]),
                SIMD4<Element>(elements[8...11]),
                SIMD4<Element>(elements[12...15]))
    }
}
