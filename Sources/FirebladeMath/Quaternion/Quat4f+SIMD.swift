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
    public init(rotation matrix4x4: Mat4x4f) {
        self.init(storage: simd.simd_quaternion(matrix4x4.storage))
    }

    public init(rotation matrix3x3: Mat3x3f) {
        self.init(storage: simd.simd_quaternion(matrix3x3.storage))
    }

    #if !canImport(simd)
    /// The normalized axis (a 3-element vector) around which the action of the quaternion `q` rotates.
    @inlinable public var axis: Vec3f {
        return simd_axis(self)
    }
    #endif

    #if !canImport(simd)
    /// The conjugate of the quaternion `q`.
    @inlinable public var conjugate: Quat4f {
        return simd_conjugate(self)
    }
    #endif
}
#endif
