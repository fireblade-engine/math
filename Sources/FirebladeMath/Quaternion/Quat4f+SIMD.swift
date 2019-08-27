//
//  Quat4f+SIMD.swift
//  FirebladeMath
//
//  Created by Christian Treffs on 27.08.19.
//

#if canImport(simd)
import struct simd.quaternion.simd_quatf

import func simd.simd_quaternion
import func simd.simd_axis
import func simd.simd_conjugate
import func simd.simd_inverse

extension Quat4f {
    public init(_ x: Float, _ y: Float, _ z: Float, _ w: Float) {
        self.init(ix: x, iy: y, iz: z, r: w)
    }

    @inlinable public var x: Float { return self.imag.x }
    @inlinable public var y: Float { return self.imag.y }
    @inlinable public var z: Float { return self.imag.z }
    @inlinable public var w: Float { return self.real }

    /// Constructs a quaternion from a four-element vector.
    /// - Parameter vector: A four-element vector.
    ///
    /// Note that the imaginary (vector) part of the quaternion comes
    /// from lanes 0, 1, and 2 of the vector, and the real (scalar) part comes from
    /// lane 3.
    public init(_ vector: Vec4f) {
        self = simd.simd_quaternion(vector)
    }

    /*
     /// Construct a quaternion that rotates from one vector to another.
     /// - Parameter from: A normalized three-element vector.
     /// - Parameter to: A normalized three-element vector.
     ///
     /// The rotation axis is `simd_cross(from, to)`. If `from` and
     /// `to` point in opposite directions (to within machine precision), an
     ///  arbitrary rotation axis is chosen, and the angle is pi radians.
     public init(from: Vec3f, to: Vec3f) {
     self = simd_quaternion(from, to)
     }*/

    /// Construct a quaternion from a 4x4 rotation `matrix`.
    /// - Parameter matrix: A rotation matrix
    ///
    /// The last row and column of the matrix are ignored. This
    /// function is equivalent to calling simd_quaternion with the upper-left 3x3
    /// submatrix
    public init(rotation matrix: Mat4x4f) {
        self = simd.simd_quaternion(matrix)
    }

    /// The normalized axis (a 3-element vector) around which the action of the quaternion `q` rotates.
    @inlinable public var axis: Vec3f {
        return simd_axis(self)
    }

    /// The conjugate of the quaternion `q`.
    @inlinable public var conjugate: Quat4f {
        return simd_conjugate(self)
    }
}

extension Quat4f: ExpressibleByArrayLiteral {
    public init(arrayLiteral elements: Float...) {
        precondition(elements.count == 4, "Quaternion needs to be initialized with exactly 4 elements")
        self.init(ix: elements[0], iy: elements[1], iz: elements[2], r: elements[3])
    }
}
#endif
